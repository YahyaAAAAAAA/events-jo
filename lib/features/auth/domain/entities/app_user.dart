import 'package:events_jo/config/enums/user_type_enum.dart';

class AppUser {
  final String uid;
  String email;
  String name;
  UserType type;
  double latitude;
  double longitude;
  bool isOnline;

  String? stripeAccountId;
  String? onboardingStatus;
  bool? onboarded;
  bool? wasOwnerAndNowUser;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.type,
    required this.isOnline,
    required this.latitude,
    required this.longitude,
    this.stripeAccountId,
    this.onboardingStatus,
    this.onboarded,
    this.wasOwnerAndNowUser,
  });

  //convert app user to json
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'type': userTypeToString(type),
      'latitude': latitude,
      'longitude': longitude,
      'isOnline': isOnline,
      'onboardingStatus': onboardingStatus,
      'onboarded': onboarded,
      'wasOwnerAndNowUser': wasOwnerAndNowUser,
      'stripeAccountId': stripeAccountId,
    };
  }

  //convert json to app user
  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      type: userTypeFromString(jsonUser['type'].toString()),
      latitude: jsonUser['latitude'],
      longitude: jsonUser['longitude'],
      isOnline: jsonUser['isOnline'],
      stripeAccountId: jsonUser['stripeAccountId'],
      onboardingStatus: jsonUser['onboardingStatus'],
      onboarded: jsonUser['onboarded'],
      wasOwnerAndNowUser: jsonUser['wasOwnerAndNowUser'],
    );
  }
}
