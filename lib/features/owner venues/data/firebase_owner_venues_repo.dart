import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/features/owner%20venues/domain/repos/owner_venues_repo.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class FirebaseOwnerVenuesRepo implements OwnerVenuesRepo {
  //firestore instance
  FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  //setup cloudinary server (for image upload & removal)
  final cloudinary = Cloudinary.full(
    apiKey: dotenv.get('IMG_API_KEY'),
    apiSecret: dotenv.get('IMG_API_SECRET'),
    cloudName: dotenv.get('IMG_CLOUD_NAME'),
  );

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedVenuesStream(
      String id) {
    //notifies of query results at 'venues' collection with given id
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: true)
        .where('ownerId', isEqualTo: id)
        .snapshots();
  }

  @override
  Stream<QuerySnapshot<Map<String, dynamic>>> getUnapprovedVenuesStream(
      String id) {
    //notifies of query results at 'venues' collection with given id
    return firebaseFirestore
        .collection('venues')
        .where('isApproved', isEqualTo: false)
        .where('ownerId', isEqualTo: id)
        .snapshots();
  }

  //unique id
  @override
  String generateUniqueId() {
    return firebaseFirestore.collection('venues').doc().id;
  }
}
