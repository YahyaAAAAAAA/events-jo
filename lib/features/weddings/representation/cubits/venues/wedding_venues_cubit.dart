import 'package:events_jo/config/algorithms/haversine.dart';
import 'package:events_jo/config/enums/sort_direction.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';
import 'package:events_jo/features/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenuesCubit extends Cubit<WeddingVenuesStates> {
  final WeddingVenueRepo weddingVenueRepo;
  final Haversine haversine = Haversine();

  //cached list of venues
  List<WeddingVenue>? cachedVenues;
  WeddingVenuesCubit({required this.weddingVenueRepo})
      : super(WeddingVenueInit());

  //unique id
  String generateUniqueId() {
    return weddingVenueRepo.generateUniqueId();
  }

  //search list
  List<WeddingVenue> searchList(List<WeddingVenue> weddingVenueList,
      List<WeddingVenue> filterdWeddingVenuList, String venue) {
    //loading...
    emit(WeddingVenueLoading());

    weddingVenueList = sortAlpha(weddingVenueList);

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
    emit(WeddingVenuesLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //sort by city
  List<WeddingVenue> sortByCity(
    List<WeddingVenue> weddingVenueList,
    String targetCity,
  ) {
    //loading...
    emit(WeddingVenueLoading());

    weddingVenueList.sort((a, b) {
      final firstVenue = a.city.toLowerCase();
      final secondVenue = b.city.toLowerCase();

      if (firstVenue == targetCity && secondVenue != targetCity) {
        return -1;
      } else if (firstVenue != targetCity && secondVenue == targetCity) {
        return 1;
      } else {
        return 0;
      }
    });

    //done
    emit(WeddingVenuesLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //sort by price
  List<WeddingVenue> sortByPrice(
    List<WeddingVenue> weddingVenueList,
    SortDirection direction,
  ) {
    //loading...
    emit(WeddingVenueLoading());

    //ascending order
    if (direction == SortDirection.ascending) {
      weddingVenueList.sort((a, b) => a.peoplePrice.compareTo(b.peoplePrice));
    }

    //descending order
    if (direction == SortDirection.descending) {
      weddingVenueList.sort((a, b) => b.peoplePrice.compareTo(a.peoplePrice));
    }

    //done
    emit(WeddingVenuesLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //sort list alphabetically
  List<WeddingVenue> sortAlpha(List<WeddingVenue> weddingVenueList) {
    //loading..
    emit(WeddingVenueLoading());

    //start sorting
    weddingVenueList.sort(
      (a, b) => a.name.trim()[0].compareTo(b.name.trim()[0]),
    );

    //done
    emit(WeddingVenuesLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //! DEPRECATED
  //sort list based on the user's location
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
    emit(WeddingVenuesLoaded(weddingVenueList));

    return weddingVenueList;
  }

  //get all venues from database
  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await weddingVenueRepo.getAllVenues();
    cachedVenues = weddingVenuesList;

    emit(WeddingVenuesLoaded(weddingVenuesList));

    return weddingVenuesList;
  }

  Future<WeddingVenue?> getVenueById(String venueId) async {
    final venue = await weddingVenueRepo.getVenueById(venueId);
    if (venue == null) {
      return null;
    }
    return venue;
  }
}
