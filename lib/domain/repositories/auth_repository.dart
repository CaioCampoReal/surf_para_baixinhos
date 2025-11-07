import 'package:dartz/dartz.dart';
import '../entities/auth_user.dart';
import '../entities/user.dart';
import '../../core/errors/auth_failures.dart';

abstract class AuthRepository {
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