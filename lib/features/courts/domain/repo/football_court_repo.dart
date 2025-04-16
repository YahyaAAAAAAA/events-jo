import 'package:events_jo/features/courts/domain/models/football_court.dart';

abstract class FootballCourtRepo {
  Future<List<FootballCourt>> getAllCourts();
  Future<FootballCourt?> getCourt(String id);
  Future<void> approveCourt(String id);
  Future<void> suspendCourt(String id);
}
