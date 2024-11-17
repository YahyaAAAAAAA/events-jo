abstract class WeddingVenueDrinksStates {}

// initial state
class WeddingVenueDrinksInit extends WeddingVenueDrinksStates {}

//loading..
class WeddingVenueDrinksLoading extends WeddingVenueDrinksStates {}

//loaded
class WeddingVenueDrinksLoaded extends WeddingVenueDrinksStates {}

//error
class WeddingVenueDrinksError extends WeddingVenueDrinksStates {
  final String message;
  WeddingVenueDrinksError(this.message);
}
