import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminSingleOwnerStates {}

// initial state
class AdminSingleOwnerInit extends AdminSingleOwnerStates {}

// loading..
class AdminSingleOwnerLoading extends AdminSingleOwnerStates {}

// loaded
class AdminSingleOwnerLoaded extends AdminSingleOwnerStates {
  final AppUser? owner;

  AdminSingleOwnerLoaded(this.owner);
}

class AdminSingleOwnerChanged extends AdminSingleOwnerStates {}

//error
class AdminSingleOwnerError extends AdminSingleOwnerStates {
  final String messege;

  AdminSingleOwnerError(this.messege);
}
