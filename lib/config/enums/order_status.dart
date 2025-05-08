import 'package:flutter/material.dart';

enum OrderStatus {
  unpaid,
  pending,
  completed,
  canceled,
  paid,
}

extension OrderStatusExtenstions on OrderStatus {
  static OrderStatus toEnum(String status) {
    switch (status) {
      case 'unpaid':
        return OrderStatus.unpaid;
      case 'pending':
        return OrderStatus.pending;
      case 'completed':
        return OrderStatus.completed;
      case 'paid':
        return OrderStatus.paid;
      default:
        return OrderStatus.canceled;
    }
  }

  Color toColor() {
    switch (this) {
      case OrderStatus.unpaid:
        return Colors.grey;
      case OrderStatus.pending:
        return Colors.blue;
      case OrderStatus.completed:
        return Colors.green;
      case OrderStatus.paid:
        return Colors.black;
      default:
        return Colors.red;
    }
  }

  IconData toIcon() {
    switch (this) {
      case OrderStatus.unpaid:
        return Icons.money_off;
      case OrderStatus.pending:
        return Icons.hourglass_empty;
      case OrderStatus.completed:
        return Icons.check_circle;
      case OrderStatus.paid:
        return Icons.attach_money;
      default:
        return Icons.cancel;
    }
  }
}
