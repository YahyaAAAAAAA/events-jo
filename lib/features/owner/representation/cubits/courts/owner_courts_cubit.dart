import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/courts/owner_courts_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class OwnerCourtsCubit extends Cubit<OwnerCourtsStates> {
  //repo instance
  final OwnerRepo ownerRepo;
  List<FootballCourt>? footballCourts;

  OwnerCourtsCubit({required this.ownerRepo}) : super(OwnerCourtsInitial());

  Future<void> getOwnerCourts(String ownerId) async {
    emit(OwnerCourtsLoading());
    try {
      final courts = await ownerRepo.getOwnerCourts(ownerId);
      footballCourts = courts;

      emit(OwnerCourtsLoaded(courts));
    } catch (e) {
      emit(OwnerCourtsError(e.toString()));
    }
  }

  Future<void> updateVenue(
      FootballCourt court, List<dynamic> updatedImages) async {
    emit(OwnerCourtsLoading());

    await ownerRepo.updateCourtInDatabase(court, updatedImages);

    //reflect update locally
    footballCourts = footballCourts?.map((detailed) {
      return detailed.id == court.id ? court : detailed;
    }).toList();

    if (footballCourts == null) {
      getOwnerCourts(court.ownerId);
    } else {
      emit(OwnerCourtsLoaded(footballCourts!));
    }
  }

  Future<void> deleteImages(String url) async {
    await ownerRepo.deleteImagesFromServer([XFile(url)]);
  }
}
