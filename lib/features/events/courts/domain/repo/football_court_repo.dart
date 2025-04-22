import 'package:events_jo/features/events/courts/domain/models/football_court.dart';

abstract class FootballCourtRepo {
  Future<List<FootballCourt>> getAllCourts();
  Future<FootballCourt?> getCourt(String id);
  Future<void> rateVenue({
    required String courtId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  });
  Future<void> approveCourt(String id);
  Future<void> suspendCourt(String id);
}
