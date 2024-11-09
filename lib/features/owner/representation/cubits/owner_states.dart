abstract class OwnerStates {}

//init state
class OwnerInitial extends OwnerStates {}

//loading...
class OwnerLoading extends OwnerStates {
  final String messege;
  OwnerLoading(this.messege);
}

//done
class OwnerLoaded extends OwnerStates {}

//error state
class OwnerError extends OwnerStates {
  final String message;
  OwnerError(this.message);
}
