// Outlines the auth operations

import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/config/enums/user%20type/user_type_enum.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  Future<AppUser?> registerWithEmailPassword(
      String name,
      String email,
      String password,
      double latitude,
      double longitude,
      UserType type,
      bool isOnline);

  Future<void> logout(String id, UserType userType);

  Future<AppUser?> getCurrentUser();

  //the following methods are helper methods
  //only called withing the data layer

  Future<UserType?> getUserType();

  Future<String?> getCurrentUserName();

  Future<double?> getCurrentUserLatitude(UserType? type);

  Future<double?> getCurrentUserLongitude(UserType? type);
}
