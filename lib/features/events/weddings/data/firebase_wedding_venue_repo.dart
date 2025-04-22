import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/events/weddings/domain/repo/wedding_venue_repo.dart';

class FirebaseWeddingVenueRepo implements WeddingVenueRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<WeddingVenue>> getAllVenues() async {
    //gets a reference for the specified path in firebase
    final collectionRef = firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true);

    //fetch the documents for this query
    QuerySnapshot querySnapshot = await collectionRef.get();

    //get data as json first then as list
    List<dynamic> allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //convert list to venue obj
    return allData
        .map(
          (venue) => WeddingVenue.fromJson(venue),
        )
        .toList();
  }

  @override
  Future<WeddingVenue?> getVenue(String id) async {
    final docRef = firebaseFirestore.collection('venues').doc(id);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }

    return WeddingVenue.fromJson(docSnapshot.data()!);
  }

  @override
  Future<WeddingVenueDetailed?> getDetailedVenue(String id) async {
    final venueDocRef = firebaseFirestore.collection('venues').doc(id);
    final venueDocSnapshot = await venueDocRef.get();

    if (!venueDocSnapshot.exists || venueDocSnapshot.data() == null) {
      return null;
    }

    final venue = WeddingVenue.fromJson(venueDocSnapshot.data()!);

    final mealsCollectionRef = venueDocRef.collection('meals');
    final mealsQuerySnapshot = await mealsCollectionRef.get();
    final meals = mealsQuerySnapshot.docs
        .map((doc) => WeddingVenueMeal.fromJson(doc.data()))
        .toList();

    final drinksCollectionRef = venueDocRef.collection('drinks');
    final drinksQuerySnapshot = await drinksCollectionRef.get();
    final drinks = drinksQuerySnapshot.docs
        .map((doc) => WeddingVenueDrink.fromJson(doc.data()))
        .toList();

    return WeddingVenueDetailed(
      venue: venue,
      meals: meals,
      drinks: drinks,
    );
  }

  @override
  Future<void> rateVenue({
    required String venueId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  }) async {
    final docRef = firebaseFirestore.collection('venues').doc(venueId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }

    final oldRates = List<String>.from(docSnapshot.data()?['rates'] ?? []);
    final newRate = '$rate/$userOrdersCount/$userName/$userId';

    // Check if the user has already rated
    final userRateIndex =
        oldRates.indexWhere((r) => r.split('/').last == userId);

    if (userRateIndex != -1) {
      // Update the existing rate
      oldRates[userRateIndex] = newRate;
    } else {
      // Add the new rate
      oldRates.add(newRate);
    }

    await firebaseFirestore.collection('venues').doc(venueId).update(
      {
        'rates': oldRates,
      },
    );
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
}
