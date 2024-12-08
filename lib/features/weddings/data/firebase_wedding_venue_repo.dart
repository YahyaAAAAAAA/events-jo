import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';

class FirebaseWeddingVenueRepo implements WeddingVenueRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true) // listen only to approved venues
        .snapshots();
  }

  //listen to single a venue document change
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

  //! DEPRECATED
  @override
  Future<List<WeddingVenue>> getAllVenues() async {
    //gets a reference for the specified path in firebase
    final collectionRef = firebaseFirestore.collection('venues');

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
  String generateUniqueId() {
    //current time (from year to microsecond)
    final now = DateTime.now();
    //get random number between 0 and 99999
    int randomValue = Random().nextInt(100000);

    //id example -> 2024111609413072511999
    return "${now.year}${now.month}${now.day}${now.hour}${now.minute}${now.second}${now.microsecond}$randomValue";
  }
}
