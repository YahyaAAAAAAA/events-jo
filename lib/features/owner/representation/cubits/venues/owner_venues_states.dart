import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';

abstract class OwnerVenuesStates {}

class OwnerVenuesInitial extends OwnerVenuesStates {}

class OwnerVenuesLoaded extends OwnerVenuesStates {
  final List<WeddingVenueDetailed> detailedVenues;
  OwnerVenuesLoaded(this.detailedVenues);
}

class OwnerVenuesLoading extends OwnerVenuesStates {}

class OwnerVenuesError extends OwnerVenuesStates {
  final String message;
  OwnerVenuesError(this.message);
}
