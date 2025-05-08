import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';

class WeddingVenue extends Event {
  late double peoplePrice;
  late int peopleMax;
  late int peopleMin;
  late bool isOpen;

  WeddingVenue({
    super.type = EventType.venue,
    required super.id,
    required super.name,
    required super.latitude,
    required super.longitude,
    required super.rates,
    required super.isApproved,
    required super.isBeingApproved,
    required super.pics,
    required super.ownerId,
    required super.ownerName,
    required super.startDate,
    required super.endDate,
    required super.city,
    required super.time,
    required super.stripeAccountId,
    required this.peopleMax,
    required this.peopleMin,
    required this.peoplePrice,
    required this.isOpen,
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
      'stripeAccountId': stripeAccountId,
    };
  }

  //convert json to wedding venue
  WeddingVenue.fromJson(Map<String, dynamic> jsonVenue)
      : super(
          type: EventType.venue,
          id: jsonVenue['id'],
          name: jsonVenue['name'],
          latitude: jsonVenue['latitude'].toDouble(),
          longitude: jsonVenue['longitude'].toDouble(),
          rates: List<String>.from(jsonVenue['rates'] ?? []),
          isApproved: jsonVenue['isApproved'],
          isBeingApproved: jsonVenue['isBeingApproved'],
          pics: jsonVenue['pics'],
          ownerId: jsonVenue['ownerId'],
          ownerName: jsonVenue['ownerName'],
          startDate: jsonVenue['startDate'],
          endDate: jsonVenue['endDate'],
          city: jsonVenue['city'],
          time: jsonVenue['time'],
          stripeAccountId: jsonVenue['stripeAccountId'],
        ) {
    peopleMax = jsonVenue['peopleMax'];
    peopleMin = jsonVenue['peopleMin'];
    peoplePrice = jsonVenue['peoplePrice'].toDouble();
    isOpen = jsonVenue['isOpen'];
  }
}
