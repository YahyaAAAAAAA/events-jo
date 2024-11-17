import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';
import 'package:events_jo/features/weddings/domain/repo/wedding_venue_meals_repo.dart';

class FirebaseWeddingVenueMealsRepo implements WeddingVenueMealsRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<WeddingVenueMeal>> getAllMeals(String id) async {
    //gets a reference for the specified path in firebase
    final collectionRef =
        firebaseFirestore.collection('venues').doc(id).collection('meals');

    //fetch the documents for this query
    QuerySnapshot querySnapshot = await collectionRef.get();

    //get data as json first then as list
    List<dynamic> allData = querySnapshot.docs.map((doc) {
      return doc.data();
    }).toList();

    //convert list to venue obj
    return allData
        .map(
          (meal) => WeddingVenueMeal.fromJson(meal),
        )
        .toList();
  }
}
