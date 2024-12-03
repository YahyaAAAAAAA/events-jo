import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class AdminSingleVenueStates {}

// initial state
class AdminSingleVenueInit extends AdminSingleVenueStates {}

// loading..
class AdminSingleVenueLoading extends AdminSingleVenueStates {}

// loaded
class AdminSingleVenueLoaded extends AdminSingleVenueStates {
  final WeddingVenue? venue;

  AdminSingleVenueLoaded(this.venue);
}

class AdminSingleVenueChanged extends AdminSingleVenueStates {}

//error
class AdminSingleVenueError extends AdminSingleVenueStates {
  final String messege;

  AdminSingleVenueError(this.messege);
}
