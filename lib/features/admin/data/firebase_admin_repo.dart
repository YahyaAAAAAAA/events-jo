import 'dart:convert';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/config/utils/endpoints.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/order/domain/models/e_order_detailed.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class FirebaseAdminRepo implements AdminRepo {
  //firestore instance
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //setup cloudinary server (for image upload & removal)
  final cloudinary = Cloudinary.full(
    apiKey: dotenv.get('IMG_API_KEY'),
    apiSecret: dotenv.get('IMG_API_SECRET'),
    cloudName: dotenv.get('IMG_CLOUD_NAME'),
  );

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream() {
    //notifies of query results at 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: false)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream() {
    //notifies of query results at 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedCourtsStream() {
    return firebaseFirestore
        .collection('courts')
        .where('isApproved', isEqualTo: true)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUnapprovedCourtsStream() {
    //notifies of query results at 'venues' collection
    return firebaseFirestore
        .collection('courts')
        .where('isApproved', isEqualTo: false)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream() {
    //notifies of query results at this 'users' collection
    return firebaseFirestore.collection('users').snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOwnersStream() {
    //notifies of query results at this 'owners' collection

    return firebaseFirestore.collection('owners').snapshots();
  }

  @override
  Stream<List<AppUser>> getAllOnlineUsersStream() {
    //notifies of query results at this 'users' collection
    return firebaseFirestore
        .collection('users')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return AppUser.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<AppUser>> getAllOnlineOwnersStream() {
    //notifies of query results at this 'owners' collection
    return firebaseFirestore
        .collection('owners')
        .where('isOnline', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return AppUser.fromJson(doc.data());
      }).toList();
    });
  }

  //listen to single a venue document change (for approved and unapproved)
  @override
  Stream<WeddingVenue?> getVenueStream(String id) {
    //notifies of document results at this 'owners' collection doc 'id'
    return firebaseFirestore
        .collection('venues')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.data() == null) {
        return null;
      }

      return WeddingVenue.fromJson(snapshot.data()!);
    });
  }

  @override
  Stream<FootballCourt?> getCourtStream(String id) {
    //notifies of document results at this 'owners' collection doc 'id'
    return firebaseFirestore
        .collection('courts')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.data() == null) {
        return null;
      }

      return FootballCourt.fromJson(snapshot.data()!);
    });
  }

  @override
  //listen to the meals subcollection
  Stream<List<WeddingVenueMeal>> getMealsStream(String id) {
    return firebaseFirestore
        .collection('venues')
        .doc(id)
        .collection('meals')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WeddingVenueMeal.fromJson(doc.data()))
            .toList());
  }

  @override
  //listen to the drinks subcollection
  Stream<List<WeddingVenueDrink>> getDrinksStream(String id) {
    return firebaseFirestore
        .collection('venues')
        .doc(id)
        .collection('drinks')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => WeddingVenueDrink.fromJson(doc.data()))
            .toList());
  }

  //listen to a single user document change
  @override
  Stream<AppUser?> getUserStream(String id) {
    //notifies of document results at this 'owners' collection doc 'id'
    return firebaseFirestore
        .collection('users')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.data() == null) {
        return null;
      }

      return AppUser.fromJson(snapshot.data()!);
    });
  }

  //listen to a single owner document change
  @override
  Stream<AppUser?> getOwnerStream(String id) {
    //notifies of document results at this 'owners' collection doc 'id'
    return firebaseFirestore
        .collection('owners')
        .doc(id)
        .snapshots()
        .map((snapshot) {
      if (snapshot.data() == null) {
        return null;
      }

      return AppUser.fromJson(snapshot.data()!);
    });
  }

  @override
  Future<void> approveVenue(String id) async {
    await firebaseFirestore.collection('venues').doc(id).update(
      {'isApproved': true},
    );
  }

  @override
  Future<void> suspendVenue(String id) async {
    await firebaseFirestore.collection('venues').doc(id).update(
      {'isApproved': false},
    );
  }

  @override
  Future<void> denyVenue(String id, List<dynamic> urls) async {
    try {
      //delete images from server if denied
      await deleteImagesFromServer(urls);

      final venueDocRef =
          FirebaseFirestore.instance.collection('venues').doc(id);

      //delete the 'meals' subcollection
      final mealsSnapshot = await venueDocRef.collection('meals').get();
      for (var mealDoc in mealsSnapshot.docs) {
        await mealDoc.reference.delete();
      }

      //delete the 'drinks' subcollection
      final drinksSnapshot = await venueDocRef.collection('drinks').get();
      for (var drinkDoc in drinksSnapshot.docs) {
        await drinkDoc.reference.delete();
      }

      //delete the main document
      await venueDocRef.delete();
    } catch (e) {
      Future.error("Error deleting venue: $e");
    }
  }

  @override
  Future<void> lockVenue(String id) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('venues').doc(id);
    try {
      //check if the document exists
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        //document exists, proceed to update
        await docRef.update({'isBeingApproved': true});
      } else {
        //document doesn't exist
        return;
      }
    } catch (e) {
      //error
      Future.error(e);
    }
  }

  @override
  Future<void> approveCourt(String id) async {
    await firebaseFirestore.collection('courts').doc(id).update(
      {'isApproved': true},
    );
  }

  @override
  Future<void> suspendCourt(String id) async {
    await firebaseFirestore.collection('courts').doc(id).update(
      {'isApproved': false},
    );
  }

  @override
  Future<void> denyCourt(String id, List<dynamic> urls) async {
    try {
      //delete images from server if denied
      await deleteImagesFromServer(urls);

      final courtDocRef =
          FirebaseFirestore.instance.collection('courts').doc(id);

      //delete the main document
      await courtDocRef.delete();
    } catch (e) {
      Future.error("Error deleting court: $e");
    }
  }

  @override
  Future<void> unlockVenue(String id) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('venues').doc(id);

    try {
      //check if the document exists
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        //document exists, proceed to update
        await docRef.update({'isBeingApproved': false});
      } else {
        //document doesn't exist
        return;
      }
    } catch (e) {
      //error
      Future.error(e);
    }
  }

  @override
  Future<void> lockCourt(String id) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('courts').doc(id);
    try {
      //check if the document exists
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        //document exists, proceed to update
        await docRef.update({'isBeingApproved': true});
      } else {
        //document doesn't exist
        return;
      }
    } catch (e) {
      //error
      Future.error(e);
    }
  }

  @override
  Future<void> unlockCourt(String id) async {
    DocumentReference docRef =
        await firebaseFirestore.collection('courts').doc(id);

    try {
      //check if the document exists
      DocumentSnapshot docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        //document exists, proceed to update
        await docRef.update({'isBeingApproved': false});
      } else {
        //document doesn't exist
        return;
      }
    } catch (e) {
      //error
      Future.error(e);
    }
  }

  @override
  Future<void> deleteImagesFromServer(List<dynamic> urls) async {
    //no images to delete
    if (urls.isEmpty) {
      return;
    }

    //placeholder image (don't delete)
    if (urls[0] == "https://i.ibb.co/ZVf53hB/placeholder.png") {
      return;
    }

    //request delete from server
    for (int i = 0; i < urls.length; i++) {
      await cloudinary.deleteResource(
        url: urls[i],
        resourceType: CloudinaryResourceType.image,
        invalidate: false,
      );
    }
  }

  @override
  String generateUniqueId() {
    //current time (from year to microsecond)
    final now = DateTime.now();
    //get random number between 0 and 99999
    int randomValue = Random().nextInt(100000);

    //id example -> 2024111609413072511999
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.microsecond}$randomValue";
  }

  @override
  Stream<List<EOrderDetailed>> getOrdersStream() async* {
    await for (final querySnapshot
        in firebaseFirestore.collection('orders').snapshots()) {
      List<EOrderDetailed> detailedOrders = [];

      for (var doc in querySnapshot.docs) {
        final order = EOrder.fromJson(doc.data());

        // Fetch meals
        final mealsSnapshot = await firebaseFirestore
            .collection('orders')
            .doc(order.id)
            .collection('meals')
            .get();

        final meals = mealsSnapshot.docs
            .map((mealDoc) => WeddingVenueMeal.fromJson(mealDoc.data()))
            .toList();

        // Fetch drinks
        final drinksSnapshot = await firebaseFirestore
            .collection('orders')
            .doc(order.id)
            .collection('drinks')
            .get();

        final drinks = drinksSnapshot.docs
            .map((drinkDoc) => WeddingVenueDrink.fromJson(drinkDoc.data()))
            .toList();

        detailedOrders.add(EOrderDetailed(
          order: order,
          meals: meals,
          drinks: drinks,
        ));
      }

      yield detailedOrders;
    }
  }

  @override
  Future<void> refund({
    required String paymentIntentId,
    required String orderId,
  }) async {
    try {
      final res = await http.post(
        Uri.parse(kRefund),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'paymentIntentId': paymentIntentId,
          'orderId': orderId,
        }),
      );

      final data = jsonDecode(res.body);

      return data['url'];
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> transfer({
    required String stripeAccountId,
    required String orderId,
    required double amount,
  }) async {
    try {
      final res = await http.post(
        Uri.parse(kTransfer),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'amount': amount,
          'stripeAccountId': stripeAccountId,
          'orderId': orderId,
        }),
      );

      final data = jsonDecode(res.body);

      return data['url'];
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> getBalance() async {
    try {
      final res = await http.get(
        Uri.parse(kBalance),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(res.body);

      print(data);
      return data;
    } catch (e) {
      throw Exception("Error fetching balance: $e");
    }
  }

  @override
  Future<void> getPayouts() async {
    try {
      final res = await http.get(
        Uri.parse(kPayouts),
        headers: {'Content-Type': 'application/json'},
      );

      final data = jsonDecode(res.body);

      print(data);
      return data;
    } catch (e) {
      throw Exception("Error fetching balance: $e");
    }
  }

  //! DEPRECATED
  @override
  Future<String> getWeddingOwnerName(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('owners').doc(uid).get();

    return data['name'];
  }
}
