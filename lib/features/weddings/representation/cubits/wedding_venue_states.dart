import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class WeddingVenueStates {}

// initial state
class WeddingVenueInit extends WeddingVenueStates {}

//loading..
class WeddingVenueLoading extends WeddingVenueStates {}

//loaded
class WeddingVenueLoaded extends WeddingVenueStates {}

//sort alpha
class WeddingVenuListSortedAlphabetical extends WeddingVenueStates {
  final List<WeddingVenue> weddingVenuList;
  WeddingVenuListSortedAlphabetical(this.weddingVenuList);
}

//error
class WeddingVenueError extends WeddingVenueStates {
  final String message;
  WeddingVenueError(this.message);
}
