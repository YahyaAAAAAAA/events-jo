import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';

abstract class AdminSingleVenueStates {}

// initial state
class AdminSingleVenueInit extends AdminSingleVenueStates {}

// loading..
class AdminSingleVenueLoading extends AdminSingleVenueStates {}

// loaded
class AdminSingleVenueLoaded extends AdminSingleVenueStates {
  final WeddingVenueDetailed data;

  AdminSingleVenueLoaded(this.data);
}

//change
class AdminSingleVenueChanged extends AdminSingleVenueStates {
  final String change;

  AdminSingleVenueChanged(this.change);
}

//error
class AdminSingleVenueError extends AdminSingleVenueStates {
  final String messege;

  AdminSingleVenueError(this.messege);
}
