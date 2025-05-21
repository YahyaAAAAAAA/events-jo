import 'package:events_jo/features/events/shared/domain/models/wedding_venue_detailed.dart';

abstract class SingleWeddingVenueStates {}

// initial state
class SingleWeddingVenueInit extends SingleWeddingVenueStates {}

//loading..
class SingleWeddingVenueLoading extends SingleWeddingVenueStates {}

//single venue loaded
class SingleWeddingVenueLoaded extends SingleWeddingVenueStates {
  final WeddingVenueDetailed data;

  SingleWeddingVenueLoaded(this.data);
}

//change
class SingleWeddingVenueChanged extends SingleWeddingVenueStates {
  final String change;

  SingleWeddingVenueChanged(this.change);
}

//change
class SingleWeddingVenueDeletec extends SingleWeddingVenueStates {
  SingleWeddingVenueDeletec();
}

//error
class SingleWeddingVenueError extends SingleWeddingVenueStates {
  final String message;
  SingleWeddingVenueError(this.message);
}
