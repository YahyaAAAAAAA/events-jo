import 'package:cached_network_image/cached_network_image.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/extensions/string_extensions.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/config/utils/loading/global_loading_image.dart';
import 'package:events_jo/features/events/courts/representation/cubits/single%20court/single_football_court_states.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SingleFootballCourtCubit extends Cubit<SingleFootballCourtStates> {
  final EventsRepo eventsRepo;

  SingleFootballCourtCubit({required this.eventsRepo})
      : super(SingleFootballCourtInit());

  Future<void> getCourt(String courtId) async {
    emit(SingleFootballCourtLoading());
    try {
      final footballCourt = await eventsRepo.getCourt(courtId);

      if (footballCourt == null) {
        return;
      }

      emit(SingleFootballCourtLoaded(footballCourt));
    } catch (e) {
      emit(SingleFootballCourtError(e.toString()));
    }
  }

  //rate venue
  Future<void> rateVenue({
    required String courtId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  }) async {
    emit(SingleFootballCourtLoading());
    try {
      await eventsRepo.rateEvent(
        type: EventType.court,
        venueId: courtId,
        userId: userId,
        userName: userName,
        userOrdersCount: userOrdersCount,
        rate: rate,
      );
      getCourt(courtId);
    } catch (e) {
      emit(SingleFootballCourtError(e.toString()));
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
