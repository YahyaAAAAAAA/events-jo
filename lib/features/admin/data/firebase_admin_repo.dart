import 'dart:math';
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
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: false)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream() {
    //notifies of query results at this 'venues' collection
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true)
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
    firebaseFirestore
        .collection('venues')
        .doc(id)
        .collection('drinks')
        .snapshots();

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
  //todo make streams for meals,drinks and merge them
  //copyWith method for wedding venue to include meals and drinks lists

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

  //! DEPRECATED
  @override
  Future<String> getWeddingOwnerName(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('owners').doc(uid).get();

    return data['name'];
  }
}
