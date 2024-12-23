import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class ApprovedVenuesStates {}

class ApprovedVenuesInitial extends ApprovedVenuesStates {}

class ApprovedVenuesLoading extends ApprovedVenuesStates {}

class ApprovedVenuesLoaded extends ApprovedVenuesStates {
  final List<WeddingVenue> venues;

  ApprovedVenuesLoaded(this.venues);
}

class ApprovedVenuesError extends ApprovedVenuesStates {
  final String message;

  ApprovedVenuesError(this.message);
}
