import 'package:geolocator/geolocator.dart';

abstract class LocationRepo {
  Future<Position> getUserLocation();
}
