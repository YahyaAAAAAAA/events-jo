import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class AdminSingleCourtStates {}

// initial state
class AdminSingleCourtInit extends AdminSingleCourtStates {}

// loading..
class AdminSingleCourtLoading extends AdminSingleCourtStates {}

// loaded
class AdminSingleCourtLoaded extends AdminSingleCourtStates {
  final FootballCourt court;

  AdminSingleCourtLoaded(this.court);
}

//change
class AdminSingleCourtChanged extends AdminSingleCourtStates {
  final String change;

  AdminSingleCourtChanged(this.change);
}

//error
class AdminSingleCourtError extends AdminSingleCourtStates {
  final String messege;

  AdminSingleCourtError(this.messege);
}
