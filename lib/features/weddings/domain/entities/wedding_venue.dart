class WeddingVenue {
  late String id;
  late String name;
  late double latitude;
  late double longitude;
  late String owner;
  late int rate;
  late bool isOpen;
  late List<dynamic> pics;
  late List<dynamic> startDate;
  late List<dynamic> endDate;
  late List<dynamic> time;
  late int peopleMax;
  late int peopleMin;
  late double peoplePrice;

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
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
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
      'peopleMax': peopleMax,
      'peopleMin': peopleMin,
      'peoplePrice': peoplePrice,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue) {
    id = jsonVenue['id'];
    name = jsonVenue['name'];
    latitude = jsonVenue['latitude'].toDouble();
    longitude = jsonVenue['longitude'].toDouble();
    rate = jsonVenue['rate'];
    isOpen = jsonVenue['isOpen'];
    pics = jsonVenue['pics'];
    owner = jsonVenue['owner'];
    startDate = jsonVenue['startDate'];
    endDate = jsonVenue['endDate'];
    time = jsonVenue['time'];
    peopleMax = jsonVenue['peopleMax'];
    peopleMin = jsonVenue['peopleMin'];
    peoplePrice = jsonVenue['peoplePrice'].toDouble();
  }
}
