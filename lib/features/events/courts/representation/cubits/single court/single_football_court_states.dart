import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class SingleFootballCourtStates {}

// initial state
class SingleFootballCourtInit extends SingleFootballCourtStates {}

//loading..
class SingleFootballCourtLoading extends SingleFootballCourtStates {}

//single venue loaded
class SingleFootballCourtLoaded extends SingleFootballCourtStates {
  final FootballCourt court;

  SingleFootballCourtLoaded(this.court);
}

class SingleFootballCourtDeleted extends SingleFootballCourtStates {
  SingleFootballCourtDeleted();
}

//change
class SingleFootballCourtChanged extends SingleFootballCourtStates {
  final String change;

  SingleFootballCourtChanged(this.change);
}

//error
class SingleFootballCourtError extends SingleFootballCourtStates {
  final String message;
  SingleFootballCourtError(this.message);
}
