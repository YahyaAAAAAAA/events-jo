//todo this eventually will be extended to add farms,football.
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:image_picker/image_picker.dart';

abstract class OwnerRepo {
  Future<void> addVenueToDatabase({
    required String name,
    required double lat,
    required double long,
    required String ownerId,
    required String ownerName,
    required int peopleMax,
    required int peopleMin,
    required double peoplePrice,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  });

  Future<void> addVenueMealsToDatabase(
      List<WeddingVenueMeal>? meals, String docId);

  Future<void> addVenueDrinksToDatabase(
      List<WeddingVenueDrink>? drinks, String docId);

  Future<List<String>> addImagesToServer(List<XFile> images, String name);

  Future<String?> getCity(double lat, double long);

  String generateUniqueId();

  Future<List<WeddingVenueDetailed>> getOwnerVenues(String ownerId);

  Future<void> updateVenueInDatabase(WeddingVenueDetailed venueDetailed);
}
