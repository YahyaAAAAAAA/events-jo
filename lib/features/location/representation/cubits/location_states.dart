abstract class LocationStates {}

//init
class LocationInitial extends LocationStates {}

//loading...
class LocationLoading extends LocationStates {}

//loaded
class LocationLoaded extends LocationStates {}

//error
class LocationError extends LocationStates {
  final String message;

  LocationError(this.message);
}
