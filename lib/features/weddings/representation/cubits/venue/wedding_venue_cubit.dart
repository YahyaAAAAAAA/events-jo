import 'package:events_jo/config/algorithms/haversine.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueCubit extends Cubit<WeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;
  final Haversine haversine = Haversine();

  WeddingVenueCubit({required this.weddingVenueRepo})
      : super(WeddingVenueInit());

  //listen to venues stream (in real time)
  void getWeddingVenuesStream() {
    //loading...
    emit(WeddingVenueLoading());

    //start listening
    weddingVenueRepo.getWeddingVenuesStream().listen(
      (venues) {
        //done
        emit(WeddingVenueLoaded(venues));
      },
      onError: (error) {
        //error
        emit(WeddingVenueError(error.toString()));
      },
    );
  }

  //! DEPRECATED
  //get all venues from database
  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();

    emit(WeddingVenueLoaded(weddingVenuesList));

    return weddingVenuesList;
  }

  //search given list
  List<WeddingVenue> searchList(List<WeddingVenue> weddingVenueList,
      List<WeddingVenue> filterdWeddingVenuList, String venue) {
    //loading...
    emit(WeddingVenueLoading());

    //ensure list clear
    filterdWeddingVenuList.clear();

    //start filtering
    filterdWeddingVenuList.addAll(weddingVenueList
        .where(
          (character) => character.name.toLowerCase().contains(venue),
        )
        .toList());

    //team: pass original list because we only update state (the filtered list handled in wedding page)
    //done
    emit(WeddingVenueLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //sort given list alphabetically
  List<WeddingVenue> sortAlpha(List<WeddingVenue> weddingVenuList) {
    //loading..
    emit(WeddingVenueLoading());

    //start sorting
    weddingVenuList.sort(
      (a, b) => a.name.trim()[0].compareTo(b.name.trim()[0]),
    );

    //done
    emit(WeddingVenueLoaded(weddingVenuList));

    return weddingVenuList;
  }

  //sort given list based on the user's location
  List<WeddingVenue> sortFromClosest(
      List<WeddingVenue> weddingVenuList, double lat, double long) {
    //loading..
    emit(WeddingVenueLoading());

    //same list but sorted from closest to furthest from the user (as json)
    List sortedList = haversine.getSortedLocations(
        lat, long, weddingVenuList.map((venue) => venue.toJson()).toList());

    //ensure list clear
    weddingVenuList.clear();

    //convert sorted list to wedding venue and add it
    weddingVenuList
        .addAll(sortedList.map((e) => WeddingVenue.fromJson(e)).toList());

    //done
    emit(WeddingVenueLoaded(weddingVenuList));

    return weddingVenuList;
  }
}
