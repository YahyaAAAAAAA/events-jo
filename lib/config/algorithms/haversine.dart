import 'dart:math';

class Haversine {
// Haversine formula to calculate the distance between two lat/lon points
  double haversine(double lat1, double lon1, double lat2, double lon2) {
    const R = 6371; // Radius of Earth in kilometers

    // Convert degrees to radians
    double dLat = (lat2 - lat1) * (pi / 180);
    double dLon = (lon2 - lon1) * (pi / 180);
    lat1 = lat1 * (pi / 180);
    lat2 = lat2 * (pi / 180);

    // Haversine formula
    double a =
        pow(sin(dLat / 2), 2) + cos(lat1) * cos(lat2) * pow(sin(dLon / 2), 2);
    double c = 2 * asin(sqrt(a));
    return R * c;
  }

  Map<String, dynamic> findClosestLocation(
      double myLat, double myLon, List<Map<String, dynamic>> locations) {
    Map<String, dynamic> closestLocation = {};
    double minDistance = double.infinity;

    for (var location in locations) {
      double locLat = double.parse(location['latitude']);
      double locLon = double.parse(location['longitude']);
      double distance = haversine(myLat, myLon, locLat, locLon);

      if (distance < minDistance) {
        minDistance = distance;
        closestLocation = location;
      }
    }

    return {'location': closestLocation, 'distance': minDistance};
  }

  // Function to return the list of locations sorted by distance
  List<Map<String, dynamic>> getSortedLocations(
      double myLat, double myLon, List<Map<String, dynamic>> locations) {
    // Add a distance key to each location map
    for (var location in locations) {
      double locLat = location['latitude'];
      double locLon = location['longitude'];
      double distance = haversine(myLat, myLon, locLat, locLon);
      location['distance'] = distance;
    }

    // Sort the locations based on the distance key
    locations.sort((a, b) => a['distance'].compareTo(b['distance']));

    return locations;
  }
}
