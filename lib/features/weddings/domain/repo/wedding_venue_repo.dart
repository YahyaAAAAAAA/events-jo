// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

abstract class WeddingVenueRepo {
  Future<List<WeddingVenue>> getAllVenues();

  Future<List<WeddingVenueMeal>> getAllMeals(String id);
}
