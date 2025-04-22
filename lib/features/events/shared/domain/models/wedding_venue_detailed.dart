import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';

class WeddingVenueDetailed {
  final WeddingVenue venue;
  final List<WeddingVenueMeal> meals;
  final List<WeddingVenueDrink> drinks;

  WeddingVenueDetailed({
    required this.venue,
    required this.meals,
    required this.drinks,
  });

  WeddingVenueDetailed copyWith({
    WeddingVenue? venue,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  }) {
    return WeddingVenueDetailed(
      venue: venue ?? this.venue,
      meals: meals ?? this.meals,
      drinks: drinks ?? this.drinks,
    );
  }
}
