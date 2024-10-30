import 'package:events_jo/features/location/domain/repo/location_repo.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationCubit extends Cubit<LocationStates> {
  final LocationRepo locationRepo;
  Position? _userLocation;

  LocationCubit({required this.locationRepo}) : super(LocationInitial());

  Future<Position?> getUserLocation() async {
    //loading...
    emit(LocationLoading());

    try {
      final Position location = await locationRepo.getUserLocation();

      _userLocation = location;

      //done
      emit(LocationLoaded(location));
      return location;
    } catch (e) {
      //error
      emit(LocationError(e.toString()));
      return null;
    }
  }

  void resetState() {
    emit(LocationInitial());
  }

  Position? get userLocation => _userLocation;
}
