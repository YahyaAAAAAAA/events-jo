import 'package:events_jo/config/enums/user_type_enum.dart';

class AppUser {
  final String uid;
  final String email;
  final String name;
  final UserType type;
  final double latitude;
  final double longitude;
  final bool isOnline;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.type,
    required this.isOnline,
    required this.latitude,
    required this.longitude,
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
    );
  }
}
