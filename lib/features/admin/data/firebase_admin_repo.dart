import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

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
  Stream<List<WeddingVenue>> getUnapprovedWeddingVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: false)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return WeddingVenue.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<WeddingVenue>> getApprovedWeddingVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return WeddingVenue.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<AppUser>> getAllUsersStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore.collection('users').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return AppUser.fromJson(doc.data());
      }).toList();
    });
  }

  @override
  Stream<List<AppUser>> getAllOwnersStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore.collection('owners').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        //get venue obj from json then as list
        return AppUser.fromJson(doc.data());
      }).toList();
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

  //! DEPRECATED
  @override
  Future<String> getWeddingOwnerName(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('owners').doc(uid).get();

    return data['name'];
  }
}
