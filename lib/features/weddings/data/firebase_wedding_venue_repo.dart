import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_repo.dart';

class FirebaseWeddingVenueRepo implements WeddingVenueRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Stream<List<WeddingVenue>> getWeddingVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true) // listen only to approved venues
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return WeddingVenue.fromJson(doc.data());
      }).toList();
    });
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
}
