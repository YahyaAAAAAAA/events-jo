import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenuesStates {}

// initial state
class WeddingVenueInit extends WeddingVenuesStates {}

//loading..
class WeddingVenueLoading extends WeddingVenuesStates {}

//all venues loaded
class WeddingVenuesLoaded extends WeddingVenuesStates {
  final List<WeddingVenue> venues;

  WeddingVenuesLoaded(this.venues);
}

//error
class WeddingVenueError extends WeddingVenuesStates {
  final String message;
  WeddingVenueError(this.message);
}
