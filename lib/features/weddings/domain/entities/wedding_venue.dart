class WeddingVenue {
  late String id;
  late String name;
  late String latitude;
  late String longitude;
  late String owner;
  late int rate;
  late bool isOpen;
  late List<dynamic> pics;
  late List<dynamic> startDate;
  late List<dynamic> endDate;
  late List<dynamic> time;

  WeddingVenue({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.rate,
    required this.isOpen,
    required this.pics,
    required this.owner,
    required this.startDate,
    required this.endDate,
    required this.time,
  });

  //convert wedding venue to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'rate': rate,
      'isOpen': isOpen,
      'pics': pics,
      'owner': owner,
      'startDate': startDate,
      'endDate': endDate,
      'time': time,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue) {
    id = jsonVenue['id'];
    name = jsonVenue['name'];
    latitude = jsonVenue['latitude'];
    longitude = jsonVenue['longitude'];
    rate = jsonVenue['rate'];
    isOpen = jsonVenue['isOpen'];
    pics = jsonVenue['pics'];
    owner = jsonVenue['owner'];
    startDate = jsonVenue['startDate'];
    endDate = jsonVenue['endDate'];
    time = jsonVenue['time'];
  }
}
