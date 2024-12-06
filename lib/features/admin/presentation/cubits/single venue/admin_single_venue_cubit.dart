import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AdminSingleVenueCubit extends Cubit<AdminSingleVenueStates> {
  final AdminRepo adminRepo;

  AdminSingleVenueCubit({required this.adminRepo})
      : super(AdminSingleVenueInit());

  //todo skeletonizer, check for performance, venues page animation,
  //merged streams for venue details, image for string algo
  void getVenueStream(String id) {
    emit(AdminSingleVenueLoading());

    final venueStream = adminRepo.getVenueStream(id);
    final mealsStream = adminRepo.getMealsStream(id);
    final drinksStream = adminRepo.getDrinksStream(id);

    //combine 3 streams in one stream
    CombineLatestStream.combine3(
      venueStream,
      mealsStream,
      drinksStream,
      (venue, meals, drinks) {
        return WeddingVenueDetailed(
            venue: venue!, meals: meals, drinks: drinks);
      },
    ).listen(
      (data) {
        final currentState = state;
        WeddingVenueDetailed currentVenue = data;

        if (currentState is AdminSingleVenueLoaded) {
          currentVenue = currentState.data;
        }

        //check if two venues are the same
        if (!identicalVenues(currentVenue, data)) {
          //notify for change on venue
          emit(AdminSingleVenueChanged(
              'A change has occurred on the Venue\'s info'));
        }

        //check if two lists of meals are the same
        if (!identicalMeals(data.meals, currentVenue.meals)) {
          //notify for change on venue
          emit(AdminSingleVenueChanged(
              'A change has occurred on the Venue\'s meals'));
        }

        //check if two lists of meals are the same
        if (!identicalDrinks(data.drinks, currentVenue.drinks)) {
          //notify for change on venue
          emit(AdminSingleVenueChanged(
              'A change has occurred on the Venue\'s drinks'));
        }

        emit(AdminSingleVenueLoaded(data));
      },
      onError: (error) {
        emit(AdminSingleVenueError(error.toString()));
      },
    );
  }

  //todo comeback if venues fields change
  //check if two venues are identical except for (isApproved,isOnline,rate)
  bool identicalVenues(WeddingVenueDetailed v1, WeddingVenueDetailed v2) {
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

    return true;
  }

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
}
