import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/ej_location.dart';
import 'package:events_jo/features/location/domain/repo/location_repo.dart';
import 'package:events_jo/features/location/representation/components/map_dialog.dart';
import 'package:events_jo/features/location/representation/components/map_dialog_preview.dart';
import 'package:events_jo/features/location/representation/cubits/location_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';

class LocationCubit extends Cubit<LocationStates> {
  final LocationRepo locationRepo;

  LocationCubit({required this.locationRepo}) : super(LocationInitial());

  Future<Position?> getUserLocation() async {
    //loading...
    emit(LocationLoading());

    try {
      final Position location = await locationRepo.getUserLocation();

      //done
      emit(LocationLoaded());

      return location;
    } catch (e) {
      //error
      emit(LocationError(e.toString()));
      return null;
    }
  }

  //this shows map for the user/event location (CAN BE CHANGED)
  Future<void> showMapDialog(
    BuildContext context, {
    required EjLocation userLocation,
    bool isInRegisterPage = false,
  }) async {
    //wait for user input
    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => MapDialog(
          latitude: userLocation.lat,
          longitude: userLocation.long,
          marker: userLocation.marker!,
          zoom: isInRegisterPage ? 3 : 15,
          //update
          onTap: (_, point) => onTap(setState, userLocation, point),
          //coords and marker to init value
          onCancel: () => onCancel(setState, context, userLocation),
          //saves coords and marker
          onConfirm: () {
            onConfirm(setState, context, userLocation);

            if (isInRegisterPage) {
              emit(LocationLoaded());
            }
          },
        ),
      ),
    );
  }

  void onConfirm(
      StateSetter setState, BuildContext context, EjLocation userLocation) {
    return setState(
      () {
        Navigator.of(context).pop();
        userLocation.initLat = userLocation.lat;
        userLocation.initLong = userLocation.long;
        userLocation.marker = Marker(
          point: LatLng(userLocation.lat, userLocation.long),
          child: Icon(
            Icons.location_pin,
            color: GColors.black,
          ),
        );
      },
    );
  }

  void onCancel(
      StateSetter setState, BuildContext context, EjLocation userLocation) {
    return setState(
      () {
        Navigator.of(context).pop();

        userLocation.lat = userLocation.initLat;
        userLocation.long = userLocation.initLong;
        userLocation.marker = Marker(
          point: LatLng(userLocation.lat, userLocation.long),
          child: Icon(
            Icons.location_pin,
            color: GColors.black,
          ),
        );
      },
    );
  }

  void onTap(
    StateSetter setState,
    EjLocation userLocation,
    LatLng point,
  ) {
    return setState(
      () {
        //update coords
        userLocation.lat = point.latitude;
        userLocation.long = point.longitude;

        //update marker
        userLocation.marker = Marker(
          point: point,
          child: Icon(
            Icons.location_pin,
            color: GColors.black,
          ),
        );
      },
    );
  }

  //this shows map for the user/event location (CANNOT BE CHANGED)
  Future<void> showMapDialogPreview(BuildContext context,
      {required EjLocation userLocation, LinearGradient? gradient}) async {
    await showDialog(
      context: context,
      builder: (context) => MapDialogPreview(
        latitude: userLocation.lat,
        longitude: userLocation.long,
        marker: userLocation.marker!,
        gradient: gradient,
      ),
    );
  }
}
