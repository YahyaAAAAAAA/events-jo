import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/double_extensions.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_detailed.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/single%20venue/single_wedding_venue_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleWeddingVenueCubit extends Cubit<SingleWeddingVenueStates> {
  final EventsRepo eventsRepo;

  SingleWeddingVenueCubit({required this.eventsRepo})
      : super(SingleWeddingVenueInit());

  WeddingVenueDetailed? updatedData;

  Future<void> getDetailedVenue(String venueId) async {
    emit(SingleWeddingVenueLoading());
    try {
      final detailedVenue = await eventsRepo.getDetailedVenue(venueId);
      updatedData = detailedVenue;

      if (detailedVenue == null) {
        return;
      }

      emit(SingleWeddingVenueLoaded(detailedVenue));
    } catch (e) {
      emit(SingleWeddingVenueError(e.toString()));
    }
  }

  //rate venue
  Future<void> rateVenue({
    required String venueId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  }) async {
    emit(SingleWeddingVenueLoading());
    try {
      await eventsRepo.rateEvent(
        type: EventType.farm,
        venueId: venueId,
        userId: userId,
        userName: userName,
        userOrdersCount: userOrdersCount,
        rate: rate,
      );
      getDetailedVenue(venueId);
    } catch (e) {
      emit(SingleWeddingVenueError(e.toString()));
    }
  }

  int getCurrentUserRate(
    List<String> rates,
    String userId,
  ) {
    final didUserOrderBefore = rates.indexWhere(
      (rate) {
        int idIndex = rate.lastIndexOf('/');
        final uid = rate.substring(idIndex + 1);

        return userId == uid;
      },
    );
    if (didUserOrderBefore != -1) {
      final rateParts = rates[didUserOrderBefore].parseRateString();
      return int.parse(rateParts[0]);
    }

    return 0;
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

  List<CachedNetworkImage> stringsToImages(List<dynamic>? pics) {
    if (pics == null) {
      return [];
    }
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
