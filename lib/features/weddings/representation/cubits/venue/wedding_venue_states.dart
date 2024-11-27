import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenueStates {}

// initial state
class WeddingVenueInit extends WeddingVenueStates {}

//loading..
class WeddingVenueLoading extends WeddingVenueStates {}

//loaded
class WeddingVenueLoaded extends WeddingVenueStates {
  final List<WeddingVenue> venues;
  WeddingVenueLoaded(this.venues);
}

//error
class WeddingVenueError extends WeddingVenueStates {
  final String message;
  WeddingVenueError(this.message);
}
