enum OrderStatus {
  pending,
  completed,
  canceled,
}

extension OrderStatusExtenstions on OrderStatus {
  static OrderStatus toEnum(String status) {
    switch (status) {
      case 'pending':
        return OrderStatus.pending;
      case 'completed':
        return OrderStatus.completed;
      default:
        return OrderStatus.canceled;
    }
  }
}
