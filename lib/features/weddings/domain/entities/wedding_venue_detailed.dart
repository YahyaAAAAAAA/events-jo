import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

class WeddingVenueDetailed {
  final WeddingVenue venue;
  final List<WeddingVenueMeal> meals;
  final List<WeddingVenueDrink> drinks;

  WeddingVenueDetailed({
    required this.venue,
    required this.meals,
    required this.drinks,
  });
}
