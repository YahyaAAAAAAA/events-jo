import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/order_status.dart';

class EOrder {
  final String id;
  final String userId;
  final String ownerId;
  final String eventId;
  final double amount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime date;
  final int startTime;
  final int endTime;
  final int people;
  final EventType eventType;
  final bool isRefundable;
  final String stripeAccountId;

  EOrder({
    required this.id,
    required this.eventType,
    required this.userId,
    required this.eventId,
    required this.ownerId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.people,
    required this.isRefundable,
    required this.stripeAccountId,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'eventType': eventType.name,
        'userId': userId,
        'eventId': eventId,
        'ownerId': ownerId,
        'amount': amount,
        'status': status.name,
        'startTime': startTime,
        'endTime': endTime,
        'people': people,
        'date': date.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
        'isRefundable': isRefundable,
        'stripeAccountId': stripeAccountId,
      };

  static EOrder fromJson(Map<String, dynamic> json) => EOrder(
        id: json['id'],
        eventType: EventTypeExtentions.fromString(json['eventType']),
        userId: json['userId'],
        eventId: json['eventId'],
        ownerId: json['ownerId'],
        amount: json['amount'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        people: json['people'],
        status: OrderStatusExtenstions.toEnum(json['status']),
        date: DateTime.parse(json['date']),
        createdAt: DateTime.parse(json['createdAt']),
        isRefundable: json['isRefundable'],
        stripeAccountId: json['stripeAccountId'],
      );
}
