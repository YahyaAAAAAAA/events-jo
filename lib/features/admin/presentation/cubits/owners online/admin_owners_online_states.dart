import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminOwnersOnlineStates {}

// initial state
class AdminOwnersOnlineInit extends AdminOwnersOnlineStates {}

// loading..
class AdminOwnersOnlineLoading extends AdminOwnersOnlineStates {}

// loaded
class AdminOwnersOnlineLoaded extends AdminOwnersOnlineStates {
  final List<AppUser> owners;

  AdminOwnersOnlineLoaded(this.owners);
}

//error
class AdminOwnersOnlineError extends AdminOwnersOnlineStates {
  final String messege;

  AdminOwnersOnlineError(this.messege);
}
