import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminUsersOnlineStates {}

// initial state
class AdminUsersOnlineInit extends AdminUsersOnlineStates {}

// loading..
class AdminUsersOnlineLoading extends AdminUsersOnlineStates {}

// loaded
class AdminUsersOnlineLoaded extends AdminUsersOnlineStates {
  final List<AppUser> users;

  AdminUsersOnlineLoaded(this.users);
}

//error
class AdminUsersOnlineError extends AdminUsersOnlineStates {
  final String messege;

  AdminUsersOnlineError(this.messege);
}
