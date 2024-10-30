class WeddingVenue {
  late String name;
  late String openTime;
  late String latitude;
  late String longitude;
  late int rate;
  late bool isOpen;
  late List<dynamic> pics;
  late String owner;

  WeddingVenue({
    required this.name,
    required this.openTime,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.isOpen,
    required this.pics,
    required this.owner,
  });

  //convert wedding venue to json
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'openTime': openTime,
      'latitude': latitude,
      'longitude': longitude,
      'rate': rate,
      'isOpen': isOpen,
      'pics': pics,
      'owner': owner,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue) {
    name = jsonVenue['name'];
    openTime = jsonVenue['openTime'];
    latitude = jsonVenue['latitude'];
    longitude = jsonVenue['longitude'];
    rate = jsonVenue['rate'];
    isOpen = jsonVenue['isOpen'];
    pics = jsonVenue['pics'];
    owner = jsonVenue['owner'];
  }
}
