import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/repo/weddin_venue_drinks_repo.dart';

class FirebaseWeddingVenueDrinksRepo implements WeddingVenueDrinksRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<WeddingVenueDrink>> getAllDrinks(String id) async {
    //gets a reference for the specified path in firebase
    final collectionRef =
        firebaseFirestore.collection('venues').doc(id).collection('drinks');

    //fetch the documents for this query
    QuerySnapshot querySnapshot = await collectionRef.get();

    //get data as json first then as list
    List<dynamic> allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //convert list to venue drink obj
    return allData
        .map(
          (drink) => WeddingVenueDrink.fromJson(drink),
        )
        .toList();
  }
}
