import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class OwnerApprovedVenuesStates {}

class OwnerApprovedVenuesInitial extends OwnerApprovedVenuesStates {}

class OwnerApprovedVenuesLoading extends OwnerApprovedVenuesStates {}

class OwnerApprovedVenuesLoaded extends OwnerApprovedVenuesStates {
  final List<WeddingVenue> venues;

  OwnerApprovedVenuesLoaded(this.venues);
}

class OwnerApprovedVenuesError extends OwnerApprovedVenuesStates {
  final String message;

  OwnerApprovedVenuesError(this.message);
}
