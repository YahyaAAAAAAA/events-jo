import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminUsersCountStates {}

// initial state
class AdminUsersCountInit extends AdminUsersCountStates {}

// loading..
class AdminUsersCountLoading extends AdminUsersCountStates {}

// loaded
class AdminUsersCountLoaded extends AdminUsersCountStates {
  final List<AppUser> users;

  AdminUsersCountLoaded(this.users);
}

//error
class AdminUsersCountError extends AdminUsersCountStates {
  final String messege;

  AdminUsersCountError(this.messege);
}
