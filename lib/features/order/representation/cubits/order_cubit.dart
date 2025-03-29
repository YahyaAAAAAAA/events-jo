import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/order_repo.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/pages/cashout_modal_sheet.dart';
import 'package:flutter/material.dart';
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

  Future<void> getUserOrders(String userId) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getUserOrders(userId);
      emit(UserOrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<List<DateTimeRange>?> getVenueOrders(String userId) async {
    emit(OrderLoading());
    try {
      final venueOrders = await orderRepo.getVenueOrders(userId);

      emit(VenueOrdersLoaded(venueOrders));
      return venueOrders;
    } catch (e) {
      emit(OrderError(e.toString()));
      return null;
    }
  }

  Future<dynamic> showCashoutSheet({
    required BuildContext context,
    required String paymentMethod,
    required String ownerId,
    required String venueId,
    required String userId,
    required DateTime? date,
    required int startTime,
    required int endTime,
    required int people,
    required double totalAmount,
    required List<WeddingVenueMeal> meals,
    required List<WeddingVenueDrink> drinks,
  }) {
    return showModalBottomSheet(
      context: context,
      backgroundColor: GColors.whiteShade3,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kOuterRadius),
        ),
      ),
      showDragHandle:
          state is OrderLoading || state is OrderAdded ? false : true,
      isDismissible:
          state is OrderLoading || state is OrderAdded ? false : true,
      enableDrag: state is OrderLoading || state is OrderAdded ? false : true,
      builder: (context) {
        return CashoutModalSheet(
          paymentMethod: paymentMethod,
          totalAmount: totalAmount,
          ownerId: ownerId,
          venueId: venueId,
          userId: userId,
          date: date,
          startTime: startTime,
          endTime: endTime,
          people: people,
          meals: meals,
          drinks: drinks,
        );
      },
    );
  }
}
