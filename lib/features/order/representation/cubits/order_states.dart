import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';

abstract class OrderStates {}

class OrderInitial extends OrderStates {}

class OrderLoading extends OrderStates {}

class OrderLoaded extends OrderStates {
  final List<EOrderDetailed> orders;
  OrderLoaded(this.orders);
}

class OrderAdded extends OrderStates {}

class OrderError extends OrderStates {
  final String message;

  OrderError(this.message);
}
