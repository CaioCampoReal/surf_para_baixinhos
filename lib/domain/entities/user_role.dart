enum UserRole { client, admin }

extension UserRoleExtension on UserRole {
  String get stringValue {
    switch (this) {
      case UserRole.admin:
        return 'admin';
      case UserRole.client:
        return 'client';
    }
  }

  String get displayName {
    switch (this) {
      case UserRole.admin:
        return 'Administrador';
      case UserRole.client:
        return 'Cliente';
    }
  }
}

UserRole userRoleFromString(String roleString) {
  switch (roleString) {
    case 'admin':
      return UserRole.admin;
    case 'client':
    default:
      return UserRole.client;
  }
}