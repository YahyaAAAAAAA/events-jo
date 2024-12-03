import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdminSingleVenueCubit extends Cubit<AdminSingleVenueStates> {
  final AdminRepo adminRepo;

  AdminSingleVenueCubit({required this.adminRepo})
      : super(AdminSingleVenueInit());

  void getVenueStream(String id) {
    //loading...
    emit(AdminSingleVenueLoading());

    adminRepo.getVenueStream(id).listen(
      (venue) {
        if (venue == null) {
          //error
          emit(AdminSingleVenueError('User doesn\'t exist'));
          return;
        }

        final currentState = state;
        WeddingVenue? currentVenue = venue;

        if (currentState is AdminSingleVenueLoaded) {
          currentVenue = currentState.venue;
        }

        //check if two objects are the same
        if (!identicalVenues(currentVenue!, venue)) {
          //notify for change
          emit(AdminSingleVenueChanged());
        }

        //done
        emit(AdminSingleVenueLoaded(venue));
      },
      onError: (error) {
        //error
        emit(AdminSingleVenueError(error.toString()));
      },
    );
  }

  //todo comeback if venues fields change
  //check if two venues are identical except for (isApproved,isOnline,rate)
  bool identicalVenues(WeddingVenue v1, WeddingVenue v2) {
    if (v1.id != v2.id) {
      return false;
    }
    if (v1.name != v2.name) {
      return false;
    }
    if (v1.ownerId != v2.ownerId) {
      return false;
    }
    if (v1.ownerName != v2.ownerName) {
      return false;
    }
    if (!listEquals(v1.endDate, v2.endDate)) {
      return false;
    }
    if (!listEquals(v1.startDate, v2.startDate)) {
      return false;
    }
    if (v1.latitude != v2.latitude) {
      return false;
    }
    if (v1.longitude != v2.longitude) {
      return false;
    }
    if (!listEquals(v1.time, v2.time)) {
      return false;
    }
    if (v1.peopleMax != v2.peopleMax) {
      return false;
    }
    if (v1.peopleMin != v2.peopleMin) {
      return false;
    }
    if (v1.peoplePrice != v2.peoplePrice) {
      return false;
    }
    if (!listEquals(v1.pics, v2.pics)) {
      return false;
    }

    return true;
  }
}
