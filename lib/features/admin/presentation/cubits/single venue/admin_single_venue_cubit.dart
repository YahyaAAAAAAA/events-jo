import 'package:events_jo/config/preferences/preferences.dart';
import 'package:events_jo/config/utils/identical_objects.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/admin/presentation/cubits/single%20venue/admin_single_venue_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class AdminSingleVenueCubit extends Cubit<AdminSingleVenueStates> {
  final AdminRepo adminRepo;

  AdminSingleVenueCubit({required this.adminRepo})
      : super(AdminSingleVenueInit());

  void getVenueStream(String id) {
    emit(AdminSingleVenueLoading());

    final venueStream = adminRepo.getVenueStream(id);
    final mealsStream = adminRepo.getMealsStream(id);
    final drinksStream = adminRepo.getDrinksStream(id);

    //combine 3 streams in one stream
    CombineLatestStream.combine3(
      venueStream,
      mealsStream,
      drinksStream,
      (venue, meals, drinks) {
        //venue doesn't exist
        if (venue == null) {
          return null;
        }
        return WeddingVenueDetailed(venue: venue, meals: meals, drinks: drinks);
      },
    ).listen(
      (data) async {
        //data in stream got deleted (deny action)
        if (data == null) {
          return;
        }

        final currentState = state;
        WeddingVenueDetailed currentVenue = data;

        if (currentState is AdminSingleVenueLoaded) {
          currentVenue = currentState.data;
        }

        //check if two venues are the same
        if (!identicalVenues(currentVenue, data)) {
          if (await Preferences.readBool('isAdminDenying') == false) {
            //notify for change on venue
            emit(AdminSingleVenueChanged(
                'A change has occurred on the Venue\'s info'));
          }
        }

        //check if two lists of meals are the same
        if (!identicalMeals(data.meals, currentVenue.meals)) {
          if (await Preferences.readBool('isAdminDenying') == false) {
            //notify for change on venue
            emit(AdminSingleVenueChanged(
                'A change has occurred on the Venue\'s meals'));
          }
        }

        //check if two lists of meals are the same
        if (!identicalDrinks(data.drinks, currentVenue.drinks)) {
          if (await Preferences.readBool('isAdminDenying') == false) {
            //notify for change on venue
            emit(AdminSingleVenueChanged(
                'A change has occurred on the Venue\'s drinks'));
          }
        }

        emit(AdminSingleVenueLoaded(data));
      },
      onError: (error) {
        emit(AdminSingleVenueError(error.toString()));
      },
    );
  }
}
