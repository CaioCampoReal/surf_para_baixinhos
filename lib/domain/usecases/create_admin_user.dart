import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failures.dart';

class CreateAdminUser {
  final AuthRepository repository;

  CreateAdminUser(this.repository);

  Future<Either<AuthFailure, User>> call({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await repository.createAdminUser(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}