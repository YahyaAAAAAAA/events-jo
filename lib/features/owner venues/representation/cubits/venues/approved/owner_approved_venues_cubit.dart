import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/utils/delay.dart';
import 'package:events_jo/features/owner%20venues/domain/repos/owner_venues_repo.dart';
import 'package:events_jo/features/owner%20venues/representation/cubits/venues/approved/owner_approved_venues_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerApprovedVenuesCubit extends Cubit<OwnerApprovedVenuesStates> {
  final OwnerVenuesRepo ownerVenuesRepo;

  OwnerApprovedVenuesCubit({required this.ownerVenuesRepo})
      : super(OwnerApprovedVenuesInitial());

  List<WeddingVenue> getApprovedVenuesStream(String id) {
    //loading...
    emit(OwnerApprovedVenuesLoading());

    List<WeddingVenue> weddingVenues = [];

    ownerVenuesRepo.getApprovedVenuesStream(id).listen(
      (snapshot) async {
        final currentState = state;
        List<WeddingVenue> currentVenues = [];

        await Delay.halfSecond();

        //get current venues
        if (currentState is OwnerApprovedVenuesLoaded) {
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

        emit(OwnerApprovedVenuesLoaded(currentVenues));
      },
      onError: (error) {
        //error
        emit(OwnerApprovedVenuesError(error.toString()));
        return [];
      },
    );

    return weddingVenues;
  }

  //unique id
  String generateUniqueId() {
    return ownerVenuesRepo.generateUniqueId();
  }
}
