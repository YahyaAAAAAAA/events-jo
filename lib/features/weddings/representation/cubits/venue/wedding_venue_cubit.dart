import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/algorithms/haversine.dart';
import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/venue/wedding_venue_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenueCubit extends Cubit<WeddingVenueStates> {
  final WeddingVenueRepo weddingVenueRepo;
  final Haversine haversine = Haversine();

  WeddingVenueCubit({required this.weddingVenueRepo})
      : super(WeddingVenueInit());

  //listen to venues stream
  List<WeddingVenue> getWeddingVenuesStream() {
    //loading...
    emit(WeddingVenueLoading());

    List<WeddingVenue> weddingVenues = [];

    //start listening
    weddingVenueRepo.getWeddingVenuesStream().listen(
      (snapshot) async {
        final currentState = state;
        List<WeddingVenue> currentVenues = [];

        await Delay.oneSecond();

        //get current venues
        if (currentState is WeddingVenueLoaded) {
          currentVenues = List.from(currentState.venues);
        }

        for (var change in snapshot.docChanges) {
          //get change data
          final data = change.doc.data();

          //ignore if change is null
          if (data == null) continue;

          //current venue for the change
          final venue = WeddingVenue.fromJson(data);

          //add
          if (change.type == DocumentChangeType.added) {
            //check if the venue already exists before adding
            final exists = currentVenues.any((v) => v.id == venue.id);
            if (!exists) {
              currentVenues.add(venue);
            }
          }
          //update
          else if (change.type == DocumentChangeType.modified) {
            //get updated venue index
            final index = currentVenues.indexWhere((v) => v.id == venue.id);

            if (index != -1) {
              currentVenues[index] = venue;
            }
          }
          //remove
          else if (change.type == DocumentChangeType.removed) {
            currentVenues.removeWhere((v) => v.id == venue.id);
          }
        }

        //done
        emit(WeddingVenueLoaded(currentVenues));
      },
      onError: (error) {
        //error
        emit(WeddingVenueError(error.toString()));

        return [];
      },
    );
    return weddingVenues;
  }

  //! DEPRECATED
  //get all venues from database
  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();

    emit(WeddingVenueLoaded(weddingVenuesList));

    return weddingVenuesList;
  }

  String generateUniqueId() {
    return weddingVenueRepo.generateUniqueId();
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
  List<WeddingVenue> sortAlpha(List<WeddingVenue> weddingVenueList) {
    //loading..
    emit(WeddingVenueLoading());

    //start sorting
    weddingVenueList.sort(
      (a, b) => a.name.trim()[0].compareTo(b.name.trim()[0]),
    );

    //done
    emit(WeddingVenueLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //sort given list based on the user's location
  List<WeddingVenue> sortFromClosest(
      List<WeddingVenue> weddingVenueList, double lat, double long) {
    //loading..
    emit(WeddingVenueLoading());

    //sort from closest to furthest from the user (as json)
    List sortedList = haversine.getSortedLocations(
        lat, long, weddingVenueList.map((venue) => venue.toJson()).toList());

    //ensure list clear
    weddingVenueList.clear();

    //convert sorted list to wedding venue and add it
    weddingVenueList
        .addAll(sortedList.map((e) => WeddingVenue.fromJson(e)).toList());

    //done
    emit(WeddingVenueLoaded(weddingVenueList));

    return weddingVenueList;
  }
}
