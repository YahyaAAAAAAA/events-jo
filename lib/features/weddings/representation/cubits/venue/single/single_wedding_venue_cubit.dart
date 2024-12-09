import 'dart:async';

import 'package:events_jo/config/utils/identical_objects.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/single/single_wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SingleWeddingVenueCubit extends Cubit<SingleWeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;

  SingleWeddingVenueCubit({required this.weddingVenueRepo})
      : super(SingleWeddingVenueInit());
  StreamSubscription? subscription;

  void getSingleVenueStream(String id) {
    emit(SingleWeddingVenueLoading());

    final venueStream = weddingVenueRepo.getVenueStream(id);
    final mealsStream = weddingVenueRepo.getMealsStream(id);
    final drinksStream = weddingVenueRepo.getDrinksStream(id);

    //combine 3 streams in one stream
    subscription = CombineLatestStream.combine3(
      venueStream,
      mealsStream,
      drinksStream,
      (venue, meals, drinks) {
        //venue doesn't exist
        if (venue == null) {
          return null;
        }
        return WeddingVenueDetailed(venue: venue, meals: meals, drinks: drinks);
      },
    ).listen(
      (data) async {
        //data in stream got deleted (deny action)
        if (data == null) {
          return;
        }

        final currentState = state;
        WeddingVenueDetailed currentVenue = data;

        if (currentState is SingleWeddingVenueLoaded) {
          currentVenue = currentState.data;
        }

        //check if two venues are the same
        if (!identicalVenues(currentVenue, data)) {
          //notify for change on venue
          emit(SingleWeddingVenueChanged(
              'A change has occurred on the Venue\'s info'));
          subscription!.cancel();
        }

        //check if two lists of meals are the same
        else if (!identicalMeals(data.meals, currentVenue.meals)) {
          //notify for change on venue
          emit(SingleWeddingVenueChanged(
              'A change has occurred on the Venue\'s meals'));
        }

        //check if two lists of meals are the same
        else if (!identicalDrinks(data.drinks, currentVenue.drinks)) {
          //notify for change on venue
          emit(SingleWeddingVenueChanged(
              'A change has occurred on the Venue\'s drinks'));
        }
        //no change, load data
        else {
          emit(SingleWeddingVenueLoaded(data));
        }
      },
      onError: (error) {
        emit(SingleWeddingVenueError(error.toString()));
      },
    );
  }
}
