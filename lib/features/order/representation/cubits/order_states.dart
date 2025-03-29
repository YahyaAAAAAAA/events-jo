import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:flutter/material.dart';

abstract class OrderStates {}

class OrderInitial extends OrderStates {}

class OrderLoading extends OrderStates {}

class UserOrdersLoaded extends OrderStates {
  final List<EOrderDetailed> orders;
  UserOrdersLoaded(this.orders);
}

class VenueOrdersLoaded extends OrderStates {
  final List<DateTimeRange>? orders;
  VenueOrdersLoaded(this.orders);
}

class OrderAdded extends OrderStates {}

class OrderError extends OrderStates {
  final String message;

  OrderError(this.message);
}
