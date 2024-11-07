import 'package:events_jo/config/alogrithms/haversine.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class alphabetically extends Cubit<WeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;
  final Haversine haversine = Haversine();

  alphabetically({required this.weddingVenueRepo}) : super(WeddingVenueInit());

  //get all venues from database
  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();
    emit(WeddingVenueLoaded());

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

    //done
    emit(WeddingVenueLoaded());

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
    emit(WeddingVenueLoaded());

    return weddingVenuList;
  }

  //sort given list based on the user's location
  List<WeddingVenue> sortFromClosest(List<WeddingVenue> weddingVenuList) {
    //loading..
    emit(WeddingVenueLoading());

    //same list but sorted from closest to furthest from the user (as json)
    List sortedList = haversine.getSortedLocations(32.05686218187307,
        36.12490100936145, weddingVenuList.map((e) => e.toJson()).toList());

    //ensure list clear
    weddingVenuList.clear();

    //convert sorted list to wedding venue and add it
    weddingVenuList
        .addAll(sortedList.map((e) => WeddingVenue.fromJson(e)).toList());

    //done
    emit(WeddingVenueLoaded());

    return weddingVenuList;
  }
}
