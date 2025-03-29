import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/config/extensions/double_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/identical_objects.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/single%20venue/single_wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class SingleWeddingVenueCubit extends Cubit<SingleWeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;

  SingleWeddingVenueCubit({required this.weddingVenueRepo})
      : super(SingleWeddingVenueInit());

  WeddingVenueDetailed? updatedData;

  WeddingVenueDetailed? getSingleVenueStream(String id) {
    emit(SingleWeddingVenueLoading());

    final venueStream = weddingVenueRepo.getVenueStream(id);
    final mealsStream = weddingVenueRepo.getMealsStream(id);
    final drinksStream = weddingVenueRepo.getDrinksStream(id);

    //combine 3 streams in one stream
    CombineLatestStream.combine3(
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
        //to make firebase send messages on a platform thread.
        final currentState = state;
        WeddingVenueDetailed currentData = data;
        updatedData = data;

        if (currentState is SingleWeddingVenueLoaded) {
          currentData = currentState.data;
        }

        //check if two venues are the same
        if (!identicalVenues(
          currentData,
          data,
          UserType.user,
        )) {
          //notify for change on venue
          emit(SingleWeddingVenueChanged(
              'A change has occurred on the Venue\'s info'));
        }

        //check if two lists of meals are the same
        else if (!identicalMeals(data.meals, currentData.meals)) {
          //notify for change on venue
          emit(SingleWeddingVenueChanged(
              'A change has occurred on the Venue\'s meals'));
        }

        //check if two lists of meals are the same
        else if (!identicalDrinks(data.drinks, currentData.drinks)) {
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
    return null;
  }

  //calculates & updates prices for drinks
  void calculateIndividualMealsPrice(WeddingVenueMeal meal, double value) {
    emit(SingleWeddingVenueLoading());

    //reset calculatedPrice value
    meal.calculatedPrice = meal.price;

    //update value in slider
    meal.selectedAmount = value.toInt();

    //calculate price
    meal.calculatedPrice = (meal.price * value.toInt()).toPrecision(2);

    emit(SingleWeddingVenueLoaded(updatedData!));
  }

  //calculates & updates prices for drinks
  void calculateIndividualDrinksPrice(WeddingVenueDrink drink, double value) {
    emit(SingleWeddingVenueLoading());

    //reset calculatedPrice value
    drink.calculatedPrice = drink.price;

    //update value in slider
    drink.selectedAmount = value.toInt();

    //calculate price
    drink.calculatedPrice = (drink.price * value.toInt()).toPrecision(2);

    emit(SingleWeddingVenueLoaded(updatedData!));
  }

  List<CachedNetworkImage> stringsToImages(List<dynamic> pics) {
    List<CachedNetworkImage> picsList = [];
    for (int i = 0; i < pics.length; i++) {
      picsList.add(
        CachedNetworkImage(
          imageUrl: pics[i],
          //waiting for image
          placeholder: (context, url) => const SizedBox(
            width: 100,
            child: GlobalLoadingImage(),
          ),
          //error getting image
          errorWidget: (context, url, error) => SizedBox(
            width: 100,
            child: Icon(
              Icons.error_outline,
              color: GColors.black,
              size: 40,
            ),
          ),
          fit: BoxFit.fill,
        ),
      );
    }
    return picsList;
  }
}
