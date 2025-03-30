import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

abstract class OrderRepo {
  Future<EOrder> createOrder(
    EOrder order,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  );
  Future<void> addMealsToOrder(List<WeddingVenueMeal>? meals, String docId);
  Future<void> addDrinksToOrder(List<WeddingVenueDrink>? drinks, String docId);
  Future<List<EOrderDetailed>> getOrders(String fromId, String id);
  Future<List<DateTimeRange>> getVenueOrders(String venueId);
  Future<void> updateOrderStatus(String orderId, OrderStatus status);
}
