import 'package:events_jo/config/enums/event_type.dart';

abstract class Event {
  final String id;
  final String name;
  final String city;
  final double latitude;
  final double longitude;
  final bool isApproved;
  final bool isBeingApproved;
  final String ownerId;
  final String ownerName;
  final List<dynamic> startDate;
  final List<dynamic> endDate;
  final List<dynamic> time;
  final List<String> rates;
  final EventType type;
  final String stripeAccountId;
  List<dynamic> pics;

  Event({
    required this.id,
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.isApproved,
    required this.isBeingApproved,
    required this.ownerId,
    required this.ownerName,
    required this.startDate,
    required this.endDate,
    required this.time,
    required this.rates,
    required this.type,
    required this.stripeAccountId,
    this.pics = const ['https://i.ibb.co/ZVf53hB/placeholder.png'],
    this.city = 'CNF',
  });

  factory Event.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      throw ArgumentError('JSON map cannot be empty');
    }

    throw UnimplementedError(
        'fromJson factory constructor is not implemented yet');
  }

  Map<String, dynamic> toJson();
}
