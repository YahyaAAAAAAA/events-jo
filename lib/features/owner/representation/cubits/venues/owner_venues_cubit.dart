import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OwnerVenuesCubit extends Cubit<OwnerVenuesStates> {
  //repo instance
  final OwnerRepo ownerRepo;
  List<WeddingVenueDetailed>? venuesDetailed;

  OwnerVenuesCubit({required this.ownerRepo}) : super(OwnerVenuesInitial());

  Future<void> getOwnerVenues(String ownerId) async {
    emit(OwnerVenuesLoading());
    try {
      final venues = await ownerRepo.getOwnerVenues(ownerId);
      venuesDetailed = venues;

      emit(OwnerVenuesLoaded(venues));
    } catch (e) {
      emit(OwnerVenuesError(e.toString()));
    }
  }

  Future<void> updateVenue(
      WeddingVenueDetailed updatedVenue, List<dynamic> updatedImages) async {
    emit(OwnerVenuesLoading());

    await ownerRepo.updateVenueInDatabase(updatedVenue, updatedImages);

    //reflect update locally
    venuesDetailed = venuesDetailed?.map((detailed) {
      return detailed.venue.id == updatedVenue.venue.id
          ? updatedVenue
          : detailed;
    }).toList();

    if (venuesDetailed == null) {
      getOwnerVenues(updatedVenue.venue.ownerId);
    } else {
      emit(OwnerVenuesLoaded(venuesDetailed!));
    }
  }

  Future<void> deleteImages(String url) async {
    await ownerRepo.deleteImagesFromServer([XFile(url)]);
  }
}
