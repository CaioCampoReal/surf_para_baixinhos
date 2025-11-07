import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failures.dart';

class RegisterWithEmail {
  final AuthRepository repository;

  RegisterWithEmail(this.repository);

  Future<Either<AuthFailure, User>> call({
    required String email,
    required String password,
    required String displayName,
  }) async {
    return await repository.registerWithEmailAndPassword(
      email: email,
      password: password,
      displayName: displayName,
    );
  }
}