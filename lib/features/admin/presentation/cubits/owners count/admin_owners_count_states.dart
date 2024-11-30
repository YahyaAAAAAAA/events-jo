import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminOwnersCountStates {}

// initial state
class AdminOwnersCountInit extends AdminOwnersCountStates {}

// loading..
class AdminOwnersCountLoading extends AdminOwnersCountStates {}

// loaded
class AdminOwnersCountLoaded extends AdminOwnersCountStates {
  final List<AppUser> owners;

  AdminOwnersCountLoaded(this.owners);
}

//error
class AdminOwnersCountError extends AdminOwnersCountStates {
  final String messege;

  AdminOwnersCountError(this.messege);
}
