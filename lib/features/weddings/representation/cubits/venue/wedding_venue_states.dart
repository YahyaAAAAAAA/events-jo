abstract class WeddingVenueStates {}

// initial state
class WeddingVenueInit extends WeddingVenueStates {}

//loading..
class WeddingVenueLoading extends WeddingVenueStates {}

//loaded
class WeddingVenueLoaded extends WeddingVenueStates {}

//error
class WeddingVenueError extends WeddingVenueStates {
  final String message;
  WeddingVenueError(this.message);
}
