import 'failures.dart';

class AuthFailure extends Failure {
  const AuthFailure(String message) : super(message);
}

class EmailAlreadyInUseFailure extends AuthFailure {
  const EmailAlreadyInUseFailure() : super('Este email já está em uso.');
}

class InvalidEmailFailure extends AuthFailure {
  const InvalidEmailFailure() : super('Email inválido.');
}

class WeakPasswordFailure extends AuthFailure {
  const WeakPasswordFailure() : super('Senha muito fraca.');
}

class UserNotFoundFailure extends AuthFailure {
  const UserNotFoundFailure() : super('Usuário não encontrado.');
}

class WrongPasswordFailure extends AuthFailure {
  const WrongPasswordFailure() : super('Senha incorreta.');
}

class NetworkAuthFailure extends AuthFailure {
  const NetworkAuthFailure() : super('Erro de conexão.');
}