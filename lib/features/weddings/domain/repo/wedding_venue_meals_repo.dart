// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

abstract class WeddingVenueMealsRepo {
  Future<List<WeddingVenueMeal>> getAllMeals(String id);
}
