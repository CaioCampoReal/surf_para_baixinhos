import 'package:dartz/dartz.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failures.dart';

class SignOut {
  final AuthRepository repository;

  SignOut(this.repository);

  Future<Either<AuthFailure, Unit>> call() async {
    return await repository.signOut();
  }
}