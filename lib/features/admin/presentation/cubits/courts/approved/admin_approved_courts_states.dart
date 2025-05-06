import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class AdminApprovedCourtsStates {}

// initial state
class AdminApprovedCourtsInit extends AdminApprovedCourtsStates {}

// loading..
class AdminApprovedCourtsLoading extends AdminApprovedCourtsStates {}

// loaded
class AdminApprovedCourtsLoaded extends AdminApprovedCourtsStates {
  final List<FootballCourt> courts;

  AdminApprovedCourtsLoaded(this.courts);
}

class AdminApprovedCourtsSuspendActionLoading
    extends AdminApprovedCourtsStates {}

class AdminApprovedCourtsSuspendActionLoaded
    extends AdminApprovedCourtsStates {}

// error
class AdminApprovedCourtsError extends AdminApprovedCourtsStates {
  final String message;
  AdminApprovedCourtsError(this.message);
}
