// Outlines the auth operations

import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AuthRepo {
  Future<AppUser?> loginWithEmailPassword(String email, String password);

  Future<AppUser?> registerWithEmailPassword(String name, String email,
      String password, double latitude, double longitude, bool isOwner);

  Future<void> logout();

  Future<AppUser?> getCurrentUser();

  //the following methods are helper methods
  //only called withing the data layer

  Future<String?> getUserType();

  Future<String?> getCurrentUserName();

  Future<double?> getCurrentUserLatitude(String? type);

  Future<double?> getCurrentUserLongitude(String? type);
}
