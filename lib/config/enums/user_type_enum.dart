enum UserType {
  user,
  owner,
  admin,
}

UserType userTypeFromString(String role) {
  switch (role) {
    case 'user':
      return UserType.user;
    case 'owner':
      return UserType.owner;
    case 'admin':
      return UserType.admin;
    default:
      throw ArgumentError('Invalid user type: $role');
  }
}

String userTypeToString(UserType type) {
  switch (type) {
    case UserType.user:
      return 'user';
    case UserType.owner:
      return 'owner';
    case UserType.admin:
      return 'admin';
  }
}
