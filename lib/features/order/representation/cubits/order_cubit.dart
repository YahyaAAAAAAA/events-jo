import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/config/utils/constants.dart';
import 'package:events_jo/config/utils/global_colors.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:events_jo/features/order/domain/order_repo.dart';
import 'package:events_jo/features/order/representation/cubits/order_states.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/representation/pages/cashout_modal_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OrderCubit extends Cubit<OrderStates> {
  final OrderRepo orderRepo;
  List<EOrderDetailed>? cachedOrders;

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

      if (cache) {
        cachedOrders = orders;
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
