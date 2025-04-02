import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';

abstract class WeddingVenueRepo {
  Future<List<WeddingVenue>> getAllVenues();

  Future<WeddingVenue?> getVenue(String id);

  Future<WeddingVenueDetailed?> getDetailedVenue(String id);

  Future<void> rateVenue({
    required String venueId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  });

  String generateUniqueId();
}
