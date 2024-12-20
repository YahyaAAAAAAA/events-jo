import 'package:events_jo/features/auth/domain/entities/app_user.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  AppUser? _currentUser;

  factory UserManager() {
    return _instance;
  }

  UserManager._internal();

  AppUser? get currentUser => _currentUser;

  set currentUser(AppUser? user) {
    _currentUser = user;
  }
}
