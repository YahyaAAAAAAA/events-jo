import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_detailed.dart';

abstract class EventsRepo {
  Future<List<WeddingVenue>> getAllVenues();
  Future<List<FootballCourt>> getAllCourts();

  Future<WeddingVenue?> getVenue(String id);
  Future<FootballCourt?> getCourt(String id);

  Future<WeddingVenueDetailed?> getDetailedVenue(String id);

  Future<void> rateEvent({
    required EventType type,
    required String venueId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  });
}
