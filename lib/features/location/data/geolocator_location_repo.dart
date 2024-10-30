import 'package:events_jo/features/location/domain/repo/location_repo.dart';
import 'package:geolocator/geolocator.dart';

class GeolocatorLocationRepo implements LocationRepo {
  @override
  Future<Position> getUserLocation() async {
    //check services
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled');
    }

    //request permission
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request');
    }

    //permission granted
    return await Geolocator.getCurrentPosition();
  }
}
