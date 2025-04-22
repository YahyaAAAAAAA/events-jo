import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue.dart';

abstract class AdminApproveStates {}

// initial state
class AdminApproveInit extends AdminApproveStates {}

// loading..
class AdminApproveLoading extends AdminApproveStates {}

// loaded
class AdminApproveLoaded extends AdminApproveStates {
  final List<WeddingVenue> venues;

  AdminApproveLoaded(this.venues);
}

class AdminSuspendActionLoading extends AdminApproveStates {}

class AdminSuspendActionLoaded extends AdminApproveStates {}

// error
class AdminApproveError extends AdminApproveStates {
  final String message;
  AdminApproveError(this.message);
}
