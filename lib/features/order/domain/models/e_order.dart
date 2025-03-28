import 'package:events_jo/config/enums/order_status.dart';

class EOrder {
  final String id;
  final String userId;
  final String ownerId;
  final String venueId;
  final double amount;
  final OrderStatus status;
  final DateTime createdAt;
  final DateTime date;
  final int startTime;
  final int endTime;
  final int people;

  EOrder({
    required this.id,
    required this.userId,
    required this.venueId,
    required this.ownerId,
    required this.amount,
    required this.status,
    required this.createdAt,
    required this.startTime,
    required this.endTime,
    required this.date,
    required this.people,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'userId': userId,
        'venueId': venueId,
        'ownerId': ownerId,
        'amount': amount,
        'status': status.name,
        'startTime': startTime,
        'endTime': endTime,
        'people': people,
        'date': date.toIso8601String(),
        'createdAt': createdAt.toIso8601String(),
      };

  static EOrder fromJson(Map<String, dynamic> json) => EOrder(
        id: json['id'],
        userId: json['userId'],
        venueId: json['venueId'],
        ownerId: json['ownerId'],
        amount: json['amount'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        people: json['people'],
        status: OrderStatusExtenstions.toEnum(json['status']),
        date: DateTime.parse(json['date']),
        createdAt: DateTime.parse(json['createdAt']),
      );
}
