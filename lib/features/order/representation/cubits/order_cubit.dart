import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/order_repo.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderStates> {
  final OrderRepo orderRepo;

  OrderCubit({required this.orderRepo}) : super(OrderInitial());

  Future<void> createOrder(
    EOrder order,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  ) async {
    emit(OrderLoading());
    try {
      await orderRepo.createOrder(order, meals, drinks);
      emit(OrderAdded());
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<void> fetchUserOrders(String userId) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getUserOrders(userId);
      emit(OrderLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }
}
