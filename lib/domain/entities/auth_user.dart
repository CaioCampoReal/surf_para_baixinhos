import 'package:equatable/equatable.dart';

class AuthUser extends Equatable {
  final String uid;
  final String? email;
  final bool isEmailVerified;
  final DateTime? createdAt;

  const AuthUser({
    required this.uid,
    this.email,
    this.isEmailVerified = false,
    this.createdAt,
  });

  static const empty = AuthUser(uid: '');

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  @override
  List<Object?> get props => [uid, email, isEmailVerified, createdAt];
}