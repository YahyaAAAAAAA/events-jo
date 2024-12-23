import 'package:events_jo/config/enums/user_type_enum.dart';
import 'package:latlong2/latlong.dart';

abstract class SettingsRepo {
  Future<String?> updateUserName(String newName);

  Future<UserType?> updateUserType(UserType initType, UserType newType);

  Future<String?> updateUserEmail(
    String newEmail,
    String oldEmail,
    String password,
  );

  Future<String?> updateUserPassword(String newPassword, String oldPassword);

  Future<void> updateVenuesOwnerName(String id, String newName);

  Future<LatLng?> updateUserLocation(
      double initLat, double initLong, double newLat, double newLong);
}
