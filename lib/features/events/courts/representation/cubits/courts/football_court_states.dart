import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class FootballCourtsStates {}

class FootballCourtsInitial extends FootballCourtsStates {}

class FootballCourtsLoading extends FootballCourtsStates {}

class FootballCourtsLoaded extends FootballCourtsStates {
  final List<FootballCourt> courts;
  FootballCourtsLoaded(this.courts);
}

class FootballCourtsError extends FootballCourtsStates {
  final String message;
  FootballCourtsError(this.message);
}
