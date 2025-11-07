import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/user_role.dart';
import '../../core/errors/auth_failures.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthUser> get authStateChanges;
  AuthUser get currentUser;
  
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });
  
  Future<Either<AuthFailure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  });
  
  Future<Either<AuthFailure, User>> createAdminUser({
    required String email,
    required String password,
    required String displayName,
  });
  
  Future<Either<AuthFailure, Unit>> signOut();
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email);
  Future<Either<AuthFailure, User>> getUserData(String uid);
  Future<Either<AuthFailure, Unit>> updateUserProfile(User user);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final FirebaseFirestore _firestore;

  AuthRemoteDataSourceImpl({
    firebase_auth.FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _firestore = firestore ?? FirebaseFirestore.instance;

  @override
  Stream<AuthUser> get authStateChanges {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      return firebaseUser == null
          ? AuthUser.empty
          : AuthUser(
              uid: firebaseUser.uid,
              email: firebaseUser.email,
              isEmailVerified: firebaseUser.emailVerified,
              createdAt: firebaseUser.metadata.creationTime,
            );
    });
  }

  @override
  AuthUser get currentUser {
    final user = _firebaseAuth.currentUser;
    return user == null
        ? AuthUser.empty
        : AuthUser(
            uid: user.uid,
            email: user.email,
            isEmailVerified: user.emailVerified,
            createdAt: user.metadata.creationTime,
          );
  }

  @override
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      return await _getUserFromFirestore(userCredential.user!.uid);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(const AuthFailure('Erro desconhecido ao fazer login'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {      
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final user = User(
        uid: userCredential.user!.uid,
        email: email,
        displayName: displayName,
        role: UserRole.client, 
        createdAt: DateTime.now(),
      );

      await _firestore.collection('users').doc(user.uid).set({
        'uid': user.uid,
        'email': user.email,
        'displayName': user.displayName,
        'role': user.roleString,
        'createdAt': user.createdAt,
      });

      return Right(user);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(const AuthFailure('Erro ao criar usuário'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> createAdminUser({
    required String email,
    required String password,
    required String displayName,
  }) async {
    try {
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null) {
        return Left(const AuthFailure('Usuário não autenticado'));
      }

      final currentUserData = await _getUserFromFirestore(currentUser.uid);
      
      return await currentUserData.fold(
        (failure) => Left(failure),
        (adminUser) async {
          if (!adminUser.isAdmin) {
            return Left(const AuthFailure('Sem permissão para criar usuário admin'));
          }

          final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
            email: email,
            password: password,
          );

          final newUser = User(
            uid: userCredential.user!.uid,
            email: email,
            displayName: displayName,
            role: UserRole.admin, 
            createdAt: DateTime.now(),
          );

          await _firestore.collection('users').doc(newUser.uid).set({
            'uid': newUser.uid,
            'email': newUser.email,
            'displayName': newUser.displayName,
            'role': newUser.roleString,
            'createdAt': newUser.createdAt,
            'createdBy': adminUser.uid,
          });

          return Right(newUser);
        },
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(const AuthFailure('Erro ao criar usuário admin'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    try {
      await _firebaseAuth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(const AuthFailure('Erro ao fazer logout'));
    }
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      return const Right(unit);
    } on firebase_auth.FirebaseAuthException catch (e) {
      return Left(_handleFirebaseAuthException(e));
    } catch (e) {
      return Left(const AuthFailure('Erro ao enviar email de reset'));
    }
  }

  @override
  Future<Either<AuthFailure, User>> getUserData(String uid) async {
    return await _getUserFromFirestore(uid);
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserProfile(User user) async {
    try {
      await _firestore.collection('users').doc(user.uid).update({
        'displayName': user.displayName,
        'role': user.roleString,
        'updatedAt': DateTime.now(),
      });
      return const Right(unit);
    } catch (e) {
      return Left(const AuthFailure('Erro ao atualizar perfil'));
    }
  }

  Future<Either<AuthFailure, User>> _getUserFromFirestore(String uid) async {
    try {
      final doc = await _firestore.collection('users').doc(uid).get();
      
      if (!doc.exists) {
        return Left(const AuthFailure('Usuário não encontrado'));
      }

      final data = doc.data()!;
      return Right(User.fromMap(data));
    } catch (e) {
      return Left(const AuthFailure('Erro ao buscar dados do usuário'));
    }
  }

  AuthFailure _handleFirebaseAuthException(
    firebase_auth.FirebaseAuthException e,
  ) {
    switch (e.code) {
      case 'email-already-in-use':
        return const EmailAlreadyInUseFailure();
      case 'invalid-email':
        return const InvalidEmailFailure();
      case 'weak-password':
        return const WeakPasswordFailure();
      case 'user-not-found':
        return const UserNotFoundFailure();
      case 'wrong-password':
        return const WrongPasswordFailure();
      case 'network-request-failed':
        return const NetworkAuthFailure();
      default:
        return AuthFailure(e.message ?? 'Erro de autenticação');
    }
  }
}