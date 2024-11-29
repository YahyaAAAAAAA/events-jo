import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class AdminStates {}

// initial state
class AdminInit extends AdminStates {}

// loading..
class AdminLoading extends AdminStates {}

// loaded
class AdminLoaded extends AdminStates {
  final List<WeddingVenue> venues;
  final List<String> ownersNames;
  AdminLoaded(this.venues, this.ownersNames);
}

// error
class AdminError extends AdminStates {
  final String message;
  AdminError(this.message);
}
