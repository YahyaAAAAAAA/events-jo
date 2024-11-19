import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/location/domain/entities/user_location.dart';
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
  Future<void> showMapDialog(BuildContext context,
      {required MapLocation userLocation, bool isOnce = false}) async {
    //wait for user input
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => StatefulBuilder(
        builder: (context, setState) => MapDialog(
          latitude: userLocation.lat,
          longitude: userLocation.long,
          marker: userLocation.marker,
          zoom: isOnce ? 3 : 15,
          onTap: (tapPoint, point) {
            setState(() {
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
            });
          },
          //bring coords and marker to init value
          onCancel: () {
            Navigator.of(context).pop();
            setState(
              () {
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
          },
          //saves coords and marker new values
          onConfirm: () {
            setState(
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

            if (isOnce) {
              emit(LocationLoaded());
            }
          },
        ),
      ),
    );
  }

  //this shows map for the user/event location (CANNOT BE CHANGED)
  Future<void> showMapDialogPreview(BuildContext context,
      {required MapLocation userLocation}) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (context, animation, secondaryAnimation) => MapDialogPreview(
        latitude: userLocation.lat,
        longitude: userLocation.long,
        marker: userLocation.marker,
      ),
    );
  }
}
