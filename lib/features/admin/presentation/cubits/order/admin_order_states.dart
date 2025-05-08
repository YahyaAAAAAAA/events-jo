import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';

abstract class AdminOrderStates {}

class AdminOrderInit extends AdminOrderStates {}

class AdminOrderLoading extends AdminOrderStates {}

class AdminOrderLoaded extends AdminOrderStates {
  final List<EOrderDetailed> orders;

  AdminOrderLoaded(this.orders);
}

class AdminOrderActionLoading extends AdminOrderStates {
  final String message;

  AdminOrderActionLoading(this.message);
}

class AdminOrderActionLoaded extends AdminOrderStates {
  final String message;

  AdminOrderActionLoaded(this.message);
}

class AdminOrderError extends AdminOrderStates {
  final String message;

  AdminOrderError(this.message);
}
