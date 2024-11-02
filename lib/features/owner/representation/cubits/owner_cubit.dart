import 'package:events_jo/features/owner/domain/repo/owner_repo.dart';
import 'package:events_jo/features/owner/representation/cubits/owner_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OwnerCubit extends Cubit<OwnerStates> {
  final OwnerRepo ownerRepo;

  OwnerCubit({required this.ownerRepo}) : super(OwnerInitial());

  Future<void> addVenueToDatabase({
    required String name,
    required String lat,
    required String lon,
    required String ownerId,
    required List<int> startDate,
    required List<int> endDate,
    required List<int> time,
    List<String>? pics,
  }) async {
    try {
      //loading...
      emit(OwnerLoading());

      //add to db
      await ownerRepo.addVenueToDatabase(
        name: name,
        lat: lat,
        lon: lon,
        startDate: startDate,
        endDate: endDate,
        time: time,
        ownerId: ownerId,
        pics: pics,
      );

      //done
      emit(OwnerLoaded());
    } catch (e) {
      //error
      emit(OwnerError(e.toString()));
    }
  }
}
