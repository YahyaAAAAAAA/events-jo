import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminSingleUserStates {}

// initial state
class AdminSingleUserInit extends AdminSingleUserStates {}

// loading..
class AdminSingleUserLoading extends AdminSingleUserStates {}

// loaded
class AdminSingleUserLoaded extends AdminSingleUserStates {
  final AppUser? user;

  AdminSingleUserLoaded(this.user);
}

class AdminSingleUserChanged extends AdminSingleUserStates {}

//error
class AdminSingleUserError extends AdminSingleUserStates {
  final String messege;

  AdminSingleUserError(this.messege);
}
