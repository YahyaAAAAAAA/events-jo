import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/enums/order_status.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:events_jo/features/order/domain/order_repo.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:flutter/material.dart';

class FirebaseOrderRepo implements OrderRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<EOrder> createOrder(
    EOrder order,
    List<WeddingVenueMeal>? meals,
    List<WeddingVenueDrink>? drinks,
  ) async {
    final docRef = firebaseFirestore.collection('orders').doc(order.id);
    await docRef.set(order.toJson());

    //------------------Meals---------------------

    await addMealsToOrder(meals, order.id);

    //------------------Drinks--------------------

    await addDrinksToOrder(drinks, order.id);

    return order;
  }

  @override
  Future<void> addMealsToOrder(
      List<WeddingVenueMeal>? meals, String docId) async {
    //user didn't add meals
    if (meals == null || meals.isEmpty) {
      return;
    }

    //fixed meals id
    for (int i = 0; i < meals.length; i++) {
      meals[i].id = (i + 1).toString();
    }

    //add meals collection to user's venue
    //then add user's individual meals
    for (int i = 0; i < meals.length; i++) {
      await firebaseFirestore
          .collection('orders')
          .doc(docId)
          .collection('meals')
          .doc(meals[i].id)
          .set(meals[i].toJson());
    }
  }

  @override
  Future<void> addDrinksToOrder(
      List<WeddingVenueDrink>? drinks, String docId) async {
    //user didn't add drinks
    if (drinks == null || drinks.isEmpty) {
      return;
    }

    //fixed drinks id
    for (int i = 0; i < drinks.length; i++) {
      drinks[i].id = (i + 1).toString();
    }

    //add drinks collection to user's venue
    //then add user's individual drinks
    for (int i = 0; i < drinks.length; i++) {
      await firebaseFirestore
          .collection('orders')
          .doc(docId)
          .collection('drinks')
          .doc(drinks[i].id)
          .set(drinks[i].toJson());
    }
  }

  @override
  Future<List<EOrderDetailed>> getOrders(String byId, String id) async {
    final querySnapshot = await firebaseFirestore
        .collection('orders')
        .where(byId, isEqualTo: id)
        .get();

    List<EOrderDetailed> detailedOrders = [];

    for (var doc in querySnapshot.docs) {
      final order = EOrder.fromJson(doc.data());

      // Fetch meals for the order
      final mealsSnapshot = await firebaseFirestore
          .collection('orders')
          .doc(order.id)
          .collection('meals')
          .get();

      final meals = mealsSnapshot.docs
          .map((mealDoc) => WeddingVenueMeal.fromJson(mealDoc.data()))
          .toList();

      // Fetch drinks for the order
      final drinksSnapshot = await firebaseFirestore
          .collection('orders')
          .doc(order.id)
          .collection('drinks')
          .get();

      final drinks = drinksSnapshot.docs
          .map((drinkDoc) => WeddingVenueDrink.fromJson(drinkDoc.data()))
          .toList();

      // Add the detailed order to the list
      detailedOrders.add(EOrderDetailed(
        order: order,
        meals: meals,
        drinks: drinks,
      ));
    }

    return detailedOrders;
  }

  @override
  Future<List<DateTimeRange>> getVenueOrders(String venueId) async {
    final querySnapshot = await firebaseFirestore
        .collection('orders')
        .where('venueId', isEqualTo: venueId)
        .get();

    final reservedDateRanges = querySnapshot.docs.map((doc) {
      final data = doc.data();
      final date = DateTime.parse(data['date']);
      final startTime = data['startTime'];

      final endTime = data['endTime'];
      return DateTimeRange(
        start: date.add(Duration(hours: startTime)),
        end: date.add(Duration(hours: endTime)),
      );
    }).toList();
    return reservedDateRanges;
  }

  @override
  Future<void> updateOrderStatus(String orderId, OrderStatus status) async {
    await firebaseFirestore.collection('orders').doc(orderId).update({
      'status': status.name,
    });
  }
}
