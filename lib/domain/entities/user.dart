import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'user_role.dart';

class User extends Equatable {
  final String uid;
  final String email;
  final String displayName;
  final UserRole role;
  final DateTime createdAt;
  final DateTime? updatedAt;

  const User({
    required this.uid,
    required this.email,
    required this.displayName,
    this.role = UserRole.client,
    required this.createdAt,
    this.updatedAt,
  });

  String get roleString => role.stringValue;
  String get roleDisplayName => role.displayName;
  bool get isAdmin => role == UserRole.admin;
  bool get isClient => role == UserRole.client;

  User copyWith({
    String? displayName,
    UserRole? role,
    DateTime? updatedAt,
  }) {
    return User(
      uid: uid,
      email: email,
      displayName: displayName ?? this.displayName,
      role: role ?? this.role,
      createdAt: createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': roleString,
      'createdAt': Timestamp.fromDate(createdAt), 
      if (updatedAt != null) 'updatedAt': Timestamp.fromDate(updatedAt!),
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      uid: map['uid'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      role: userRoleFromString(map['role'] as String),
      createdAt: (map['createdAt'] as Timestamp).toDate(), 
      updatedAt: map['updatedAt'] != null 
          ? (map['updatedAt'] as Timestamp).toDate() 
          : null,
    );
  }

  @override
  List<Object?> get props => [uid, email, displayName, role, createdAt, updatedAt];

  @override
  String toString() {
    return 'User(uid: $uid, email: $email, displayName: $displayName, role: $roleDisplayName)';
  }
}