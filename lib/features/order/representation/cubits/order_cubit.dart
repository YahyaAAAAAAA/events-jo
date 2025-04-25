import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:events_jo/features/order/domain/order_repo.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/events/shared/representation/pages/cashout_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderStates> {
  final OrderRepo orderRepo;
  List<EOrderDetailed>? cachedOrders;
  String? cachedUserId;

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

  Future<void> getCachedOrders() async {
    if (cachedOrders == null) {
      return;
    }
    emit(UserOrdersLoaded(cachedOrders!));
  }

  //byId: using (ownerId,venueId,userId), id: the respective id (owner's,user's)
  Future<void> getOrders(String byId, String id, {bool cache = false}) async {
    emit(OrderLoading());
    try {
      final orders = await orderRepo.getOrders(byId, id);

      orders.sort((a, b) => b.order.createdAt.compareTo(a.order.createdAt));

      if (cache) {
        cachedOrders = orders;
        cachedUserId = id;
      }

      emit(UserOrdersLoaded(orders));
    } catch (e) {
      emit(OrderError(e.toString()));
    }
  }

  Future<List<DateTimeRange>?> getVenueReservedDates(String venueId) async {
    emit(OrderLoading());
    try {
      final venueOrders = await orderRepo.getVenueOrders(venueId);

      emit(VenueOrdersLoaded(venueOrders));
      return venueOrders;
    } catch (e) {
      emit(OrderError(e.toString()));
      return null;
    }
  }

  Future<void> updateOrderStatus(
    String byId,
    String id,
    String orderId,
    OrderStatus status, {
    bool cache = false,
  }) async {
    await orderRepo.updateOrderStatus(orderId, status);
    await getOrders(byId, id, cache: cache);
  }

  Future<int> getUserOrdersCount(String userId, String venueId) async {
    try {
      int count = await orderRepo.getUserOrdersCount(userId, venueId);

      return count;
    } catch (e) {
      emit(OrderError(e.toString()));
      return 0;
    }
  }

  Future<dynamic> showCashoutSheet({
    required BuildContext context,
    required EventType eventType,
    required String paymentMethod,
    required String ownerId,
    required String venueId,
    required String userId,
    required DateTime? date,
    required int startTime,
    required int endTime,
    required int people,
    required double totalAmount,
    required bool isRefundable,
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
      showDragHandle: false,
      isDismissible: false,
      enableDrag: false,
      builder: (context) {
        return PopScope(
          canPop: false,
          child: StatefulBuilder(builder: (context, setState) {
            return CashoutModalSheet(
              eventType: eventType,
              paymentMethod: paymentMethod,
              totalAmount: totalAmount,
              ownerId: ownerId,
              venueId: venueId,
              userId: userId,
              date: date,
              isRefundable: isRefundable,
              onRefundableChanged: (_) =>
                  setState(() => isRefundable = !isRefundable),
              startTime: startTime,
              endTime: endTime,
              people: people,
              meals: meals,
              drinks: drinks,
            );
          }),
        );
      },
    );
  }
}
