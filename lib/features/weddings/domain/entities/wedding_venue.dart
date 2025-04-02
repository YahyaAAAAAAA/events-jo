class WeddingVenue {
  late String id;
  late String name;
  late String ownerId;
  late String ownerName;
  late int peopleMax;
  late int peopleMin;
  late double latitude;
  late double longitude;
  late double peoplePrice;
  late bool isOpen;
  late bool isApproved;
  late bool isBeingApproved;
  late List<dynamic> pics;
  late List<dynamic> startDate;
  late List<dynamic> endDate;
  late List<dynamic> time;
  late List<String> rates;
  late String city;

  WeddingVenue({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.rates,
    required this.isOpen,
    required this.isApproved,
    required this.isBeingApproved,
    required this.pics,
    required this.ownerId,
    required this.ownerName,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
    required this.city,
  });

  //convert wedding venue to json
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'rates': rates,
      'isOpen': isOpen,
      'isApproved': isApproved,
      'isBeingApproved': isBeingApproved,
      'pics': pics,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'startDate': startDate,
      'endDate': endDate,
      'time': time,
      'peopleMax': peopleMax,
      'peopleMin': peopleMin,
      'peoplePrice': peoplePrice,
      'city': city,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue) {
    id = jsonVenue['id'];
    name = jsonVenue['name'];
    latitude = jsonVenue['latitude'].toDouble();
    longitude = jsonVenue['longitude'].toDouble();
    rates = List<String>.from(jsonVenue['rates']);
    isOpen = jsonVenue['isOpen'];
    isApproved = jsonVenue['isApproved'];
    isBeingApproved = jsonVenue['isBeingApproved'];
    pics = jsonVenue['pics'];
    ownerId = jsonVenue['ownerId'];
    ownerName = jsonVenue['ownerName'];
    startDate = jsonVenue['startDate'];
    endDate = jsonVenue['endDate'];
    time = jsonVenue['time'];
    peopleMax = jsonVenue['peopleMax'];
    peopleMin = jsonVenue['peopleMin'];
    peoplePrice = jsonVenue['peoplePrice'].toDouble();
    city = jsonVenue['city'];
  }
}
