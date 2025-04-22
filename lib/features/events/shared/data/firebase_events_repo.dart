import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/config/enums/event_type.dart';
import 'package:events_jo/features/events/courts/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/repo/events_repo.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_detailed.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/events/weddings/domain/entities/wedding_venue_meal.dart';

class FirebaseEventsRepo implements EventsRepo {
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
  Future<List<FootballCourt>> getAllCourts() async {
    final querySnapshot = await firebaseFirestore
        .collection('courts')
        .where('isApproved', isEqualTo: true)
        .get();

    return querySnapshot.docs
        .map((doc) => FootballCourt.fromJson(doc.data()))
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
  Future<FootballCourt?> getCourt(String id) async {
    final docSnapshot =
        await firebaseFirestore.collection('courts').doc(id).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }

    return FootballCourt.fromJson(docSnapshot.data()!);
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
  Future<void> rateEvent({
    required EventType type,
    required String venueId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  }) async {
    final String collection = type == EventType.venue ? 'venues' : 'courts';

    final docRef = firebaseFirestore.collection(collection).doc(venueId);
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

    await firebaseFirestore.collection(collection).doc(venueId).update(
      {
        'rates': oldRates,
      },
    );
  }
}
