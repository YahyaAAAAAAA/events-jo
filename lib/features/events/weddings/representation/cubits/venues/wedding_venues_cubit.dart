import 'package:events_jo/config/algorithms/ratings_utils.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/representation/cubits/venues/wedding_venues_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WeddingVenuesCubit extends Cubit<WeddingVenuesStates> {
  final EventsRepo eventsRepo;

  WeddingVenuesCubit({required this.eventsRepo}) : super(WeddingVenueInit());

  //cached list of venues
  List<WeddingVenue>? cachedVenues;

  //get all venues from database
  Future<List<WeddingVenue>> getAllVenues() async {
    emit(WeddingVenueLoading());

    final weddingVenuesList = await eventsRepo.getAllVenues();
    weddingVenuesList.sort(
      (a, b) => calculateRatings(b.rates)['averageRate']
          .toDouble()
          .compareTo(calculateRatings(a.rates)['averageRate'].toDouble()),
    );
    cachedVenues = weddingVenuesList;

    emit(WeddingVenuesLoaded(weddingVenuesList));

    return weddingVenuesList;
  }

  Future<WeddingVenue?> getVenue(String venueId) async {
    final venue = await eventsRepo.getVenue(venueId);
    if (venue == null) {
      return null;
    }
    return venue;
  }
}
