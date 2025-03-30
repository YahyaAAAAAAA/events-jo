import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/venues/owner_venues_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerVenuesCubit extends Cubit<OwnerVenuesStates> {
  //repo instance
  final OwnerRepo ownerRepo;

  OwnerVenuesCubit({required this.ownerRepo}) : super(OwnerVenuesInitial());

  Future<void> getOwnerVenues(String ownerId) async {
    emit(OwnerVenuesLoading());
    try {
      final venues = await ownerRepo.getOwnerVenues(ownerId);

      emit(OwnerVenuesLoaded(venues));
    } catch (e) {
      emit(OwnerVenuesError(e.toString()));
    }
  }
}
