abstract class OwnerStates {}

//init state
class OwnerInitial extends OwnerStates {}

//loading...
class OwnerLoading extends OwnerStates {}

//done
class OwnerLoaded extends OwnerStates {}

//error state
class OwnerError extends OwnerStates {
  final String message;
  OwnerError(this.message);
}
