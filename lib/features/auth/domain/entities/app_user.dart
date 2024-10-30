class AppUser {
  final String uid;
  final String email;
  final String name;
  final String type;
  final double latitude;
  final double longitude;

  AppUser({
    required this.uid,
    required this.email,
    required this.name,
    required this.type,
    required this.latitude,
    required this.longitude,
  });

//convert app user to json

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'email': email,
      'name': name,
      'type': type,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

//convert json to app user

  factory AppUser.fromJson(Map<String, dynamic> jsonUser) {
    return AppUser(
      uid: jsonUser['uid'],
      email: jsonUser['email'],
      name: jsonUser['name'],
      type: jsonUser['type'],
      latitude: jsonUser['latitude'],
      longitude: jsonUser['longitude'],
    );
  }
}
