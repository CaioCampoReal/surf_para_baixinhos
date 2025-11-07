import 'package:dartz/dartz.dart';
import '../../domain/entities/auth_user.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../core/errors/auth_failures.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Stream<AuthUser> get authStateChanges => remoteDataSource.authStateChanges;

  @override
  AuthUser get currentUser => remoteDataSource.currentUser;

  @override
  Future<Either<AuthFailure, User>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    return await remoteDataSource.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<Either<AuthFailure, User>> registerWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await remoteDataSource.registerWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  @override
  Future<Either<AuthFailure, User>> createAdminUser({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await remoteDataSource.createAdminUser(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  @override
  Future<Either<AuthFailure, Unit>> signOut() async {
    return await remoteDataSource.signOut();
  }

  @override
  Future<Either<AuthFailure, Unit>> sendPasswordResetEmail(String email) async {
    return await remoteDataSource.sendPasswordResetEmail(email);
  }

  @override
  Future<Either<AuthFailure, User>> getUserData(String uid) async {
    return await remoteDataSource.getUserData(uid);
  }

  @override
  Future<Either<AuthFailure, Unit>> updateUserProfile(User user) async {
    return await remoteDataSource.updateUserProfile(user);
  }
}