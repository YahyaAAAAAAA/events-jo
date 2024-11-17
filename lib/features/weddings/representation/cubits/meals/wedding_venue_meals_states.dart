abstract class WeddingVenueMealsStates {}

// initial state
class WeddingVenueMealsInit extends WeddingVenueMealsStates {}

//loading..
class WeddingVenueMealsLoading extends WeddingVenueMealsStates {}

//loaded
class WeddingVenueMealsLoaded extends WeddingVenueMealsStates {}

//error
class WeddingVenueMealsError extends WeddingVenueMealsStates {
  final String message;
  WeddingVenueMealsError(this.message);
}
