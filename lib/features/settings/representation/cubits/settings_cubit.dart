import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:events_jo/features/auth/domain/entities/user_manager.dart';
import 'package:events_jo/features/settings/domain/repos/settings_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:events_jo/features/settings/representation/cubits/settings_states.dart';
import 'package:latlong2/latlong.dart';

class SettingsCubit extends Cubit<SettingsStates> {
  final SettingsRepo settingsRepo;

  SettingsCubit({required this.settingsRepo}) : super(SettingsInitial());

  //change user's name
  Future<void> updateUserName(String newName) async {
    emit(SettingsLoading());

    try {
      //change name
      final name = await settingsRepo.updateUserName(newName);

      if (name != null) {
        //update currentUser in UserManager
        UserManager().currentUser?.name = name;

        emit(SettingsLoaded());
      } else {
        emit(SettingsError("Failed to update name"));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  //change user's type
  Future<void> updateUserType(UserType initType, UserType newType) async {
    emit(SettingsLoading());

    try {
      //change type
      final type = await settingsRepo.updateUserType(initType, newType);

      if (type != null) {
        //update currentUser in UserManager
        UserManager().currentUser?.type = type;

        emit(SettingsLoaded());
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }

  //change user's name
  Future<void> updateUserLocation(
    double initLat,
    double initLong,
    double newLat,
    double newLong,
  ) async {
    //loading...
    emit(SettingsLoading());

    try {
      //change name
      final location = await settingsRepo.updateUserLocation(
        initLat,
        initLong,
        newLat,
        newLong,
      );

      if (location != LatLng(initLat, initLong)) {
        //update currentUser in UserManager
        UserManager().currentUser?.latitude = location!.latitude;
        UserManager().currentUser?.longitude = location!.longitude;

        //done
        emit(SettingsLoaded());
      } else {
        emit(SettingsError("Failed to update name"));
      }
    } catch (e) {
      emit(SettingsError(e.toString()));
    }
  }
}
