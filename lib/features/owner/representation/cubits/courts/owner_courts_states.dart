import 'package:events_jo/features/events/shared/domain/models/football_court.dart';

abstract class OwnerCourtsStates {}

class OwnerCourtsInitial extends OwnerCourtsStates {}

class OwnerCourtsLoaded extends OwnerCourtsStates {
  final List<FootballCourt> courts;
  OwnerCourtsLoaded(this.courts);
}

class OwnerCourtsLoading extends OwnerCourtsStates {}

class OwnerCourtsError extends OwnerCourtsStates {
  final String message;
  OwnerCourtsError(this.message);
}
