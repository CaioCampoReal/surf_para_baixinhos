import 'package:dartz/dartz.dart';
import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/auth_failures.dart';

class GetCurrentUser {
  final AuthRepository repository;

  GetCurrentUser(this.repository);

  Future<Either<AuthFailure, User>> call() async {
    final authUser = repository.currentUser;
    if (authUser.isEmpty) {
      return Left(AuthFailure('Usuário não autenticado'));
    }
    return await repository.getUserData(authUser.uid);
  }
}