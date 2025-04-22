import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue.dart';

abstract class AdminUnapproveStates {}

// initial state
class AdminUnapproveInit extends AdminUnapproveStates {}

// loading..
class AdminUnapproveLoading extends AdminUnapproveStates {}

// loaded
class AdminUnapproveLoaded extends AdminUnapproveStates {
  final List<WeddingVenue> venues;

  AdminUnapproveLoaded(this.venues);
}

class AdminApproveActionLoading extends AdminUnapproveStates {}

class AdminApproveActionLoaded extends AdminUnapproveStates {}

class AdminDenyActionLoading extends AdminUnapproveStates {}

class AdminDenyActionLoaded extends AdminUnapproveStates {}

// error
class AdminUnapproveError extends AdminUnapproveStates {
  final String message;
  AdminUnapproveError(this.message);
}
