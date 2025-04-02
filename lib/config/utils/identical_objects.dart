import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/foundation.dart';

//todo comeback if venues, meals or drinks fields have changed

//check if two venues are identical
bool identicalVenues(
  WeddingVenueDetailed v1,
  WeddingVenueDetailed v2,
  UserType type,
) {
  if (v1.venue.id != v2.venue.id) {
    return false;
  }
  if (v1.venue.name != v2.venue.name) {
    return false;
  }
  if (v1.venue.ownerId != v2.venue.ownerId) {
    return false;
  }
  if (v1.venue.ownerName != v2.venue.ownerName) {
    return false;
  }
  if (!listEquals(v1.venue.endDate, v2.venue.endDate)) {
    return false;
  }
  if (!listEquals(v1.venue.startDate, v2.venue.startDate)) {
    return false;
  }
  if (v1.venue.latitude != v2.venue.latitude) {
    return false;
  }
  if (v1.venue.longitude != v2.venue.longitude) {
    return false;
  }
  if (!listEquals(v1.venue.time, v2.venue.time)) {
    return false;
  }
  if (v1.venue.peopleMax != v2.venue.peopleMax) {
    return false;
  }
  if (v1.venue.peopleMin != v2.venue.peopleMin) {
    return false;
  }
  if (v1.venue.peoplePrice != v2.venue.peoplePrice) {
    return false;
  }
  if (!listEquals(v1.venue.pics, v2.venue.pics)) {
    return false;
  }

  //checks for owners and users only
  if (type == UserType.user) {
    if (v1.venue.isBeingApproved != v2.venue.isBeingApproved) {
      return false;
    }
    if (v1.venue.isOpen != v2.venue.isOpen) {
      return false;
    }
    if (v1.venue.rates != v2.venue.rates) {
      return false;
    }
  }

  return true;
}

//check if two meals are identical
bool identicalMeals(List<WeddingVenueMeal> m1, List<WeddingVenueMeal> m2) {
  if (m1.length != m2.length) {
    return false;
  }

  //just incase
  int length = m1.length;
  if (m2.length > m1.length) {
    length = m2.length;
  }

  for (int i = 0; i < length; i++) {
    if (m1[i].name != m2[i].name) {
      return false;
    }
    if (m1[i].amount != m2[i].amount) {
      return false;
    }
    if (m1[i].price != m2[i].price) {
      return false;
    }
    if (m1[i].id != m2[i].id) {
      return false;
    }
  }

  return true;
}

//check if two drinks are identical
bool identicalDrinks(List<WeddingVenueDrink> d1, List<WeddingVenueDrink> d2) {
  if (d1.length != d2.length) {
    return false;
  }

  //just incase
  int length = d1.length;
  if (d2.length > d1.length) {
    length = d2.length;
  }

  for (int i = 0; i < length; i++) {
    if (d1[i].name != d2[i].name) {
      return false;
    }
    if (d1[i].amount != d2[i].amount) {
      return false;
    }
    if (d1[i].price != d2[i].price) {
      return false;
    }
    if (d1[i].id != d2[i].id) {
      return false;
    }
  }

  return true;
}
