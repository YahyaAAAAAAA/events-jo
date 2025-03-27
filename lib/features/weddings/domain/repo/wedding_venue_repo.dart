// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

abstract class WeddingVenueRepo {
  //get/listen to venues from database

  Stream<WeddingVenue?> getVenueStream(String id);

  Stream<List<WeddingVenueMeal>> getMealsStream(String id);

  Stream<List<WeddingVenueDrink>> getDrinksStream(String id);

  Future<List<WeddingVenue>> getAllVenues();

  String generateUniqueId();
}
