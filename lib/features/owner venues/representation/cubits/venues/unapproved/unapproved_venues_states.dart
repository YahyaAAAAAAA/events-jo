import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class UnapprovedVenuesStates {}

class UnapprovedVenuesInitial extends UnapprovedVenuesStates {}

class UnapprovedVenuesLoading extends UnapprovedVenuesStates {}

class UnapprovedVenuesLoaded extends UnapprovedVenuesStates {
  final List<WeddingVenue> venues;

  UnapprovedVenuesLoaded(this.venues);
}

class UnapprovedVenuesError extends UnapprovedVenuesStates {
  final String message;

  UnapprovedVenuesError(this.message);
}
