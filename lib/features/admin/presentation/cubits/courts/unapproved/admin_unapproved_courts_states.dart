import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class AdminUnapprovedCourtsStates {}

// initial state
class AdminUnapprovedCourtsInit extends AdminUnapprovedCourtsStates {}

// loading..
class AdminUnapprovedCourtsLoading extends AdminUnapprovedCourtsStates {}

// loaded
class AdminUnapprovedCourtsLoaded extends AdminUnapprovedCourtsStates {
  final List<FootballCourt> courts;

  AdminUnapprovedCourtsLoaded(this.courts);
}

class AdminUnapprovedCourtsApproveActionLoading
    extends AdminUnapprovedCourtsStates {}

class AdminUnapprovedCourtsApproveActionLoaded
    extends AdminUnapprovedCourtsStates {}

class AdminUnapprovedCourtsDenyActionLoading
    extends AdminUnapprovedCourtsStates {}

class AdminUnapprovedCourtsDenyActionLoaded
    extends AdminUnapprovedCourtsStates {}

// error
class AdminUnapprovedCourtsError extends AdminUnapprovedCourtsStates {
  final String message;
  AdminUnapprovedCourtsError(this.message);
}
