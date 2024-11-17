// Outlines the venue operations
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';

abstract class WeddingVenueDrinksRepo {
  Future<List<WeddingVenueDrink>> getAllDrinks(String id);
}
