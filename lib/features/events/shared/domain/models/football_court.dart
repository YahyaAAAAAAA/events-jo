import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/events/shared/domain/models/event.dart';

class FootballCourt extends Event {
  late double pricePerHour;

  FootballCourt({
    super.type = EventType.court,
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
    required this.pricePerHour,
  });

  //convert FootballCourt to JSON
  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'rates': rates,
      'isApproved': isApproved,
      'isBeingApproved': isBeingApproved,
      'pics': pics,
      'ownerId': ownerId,
      'ownerName': ownerName,
      'startDate': startDate,
      'endDate': endDate,
      'time': time,
      'city': city,
      'pricePerHour': pricePerHour,
    };
  }

  //convert JSON to FootballCourt
  FootballCourt.fromJson(Map<String, dynamic> jsonCourt)
      : super(
          type: EventType.court,
          id: jsonCourt['id'],
          name: jsonCourt['name'],
          latitude: jsonCourt['latitude'].toDouble(),
          longitude: jsonCourt['longitude'].toDouble(),
          rates: List<String>.from(jsonCourt['rates']),
          isApproved: jsonCourt['isApproved'],
          isBeingApproved: jsonCourt['isBeingApproved'],
          pics: jsonCourt['pics'],
          ownerId: jsonCourt['ownerId'],
          ownerName: jsonCourt['ownerName'],
          startDate: jsonCourt['startDate'],
          endDate: jsonCourt['endDate'],
          city: jsonCourt['city'],
          time: jsonCourt['time'],
        ) {
    pricePerHour = jsonCourt['pricePerHour'].toDouble();
  }
}
