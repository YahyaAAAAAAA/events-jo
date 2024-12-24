import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class OwnerUnapprovedVenuesStates {}

class OwnerUnapprovedVenuesInitial extends OwnerUnapprovedVenuesStates {}

class OwnerUnapprovedVenuesLoading extends OwnerUnapprovedVenuesStates {}

class OwnerUnapprovedVenuesLoaded extends OwnerUnapprovedVenuesStates {
  final List<WeddingVenue> venues;

  OwnerUnapprovedVenuesLoaded(this.venues);
}

class OwnerUnapprovedVenuesError extends OwnerUnapprovedVenuesStates {
  final String message;

  OwnerUnapprovedVenuesError(this.message);
}
