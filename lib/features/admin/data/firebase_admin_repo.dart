import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloudinary_sdk/cloudinary_sdk.dart';
import 'package:events_jo/features/admin/domain/repos/admin_repo.dart';
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
  Stream<List<WeddingVenue>> getWeddingVenuesRequestsStream() {
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
  Future<void> deleteImagesFromServer(List<String> urls) async {
    //no images to delete
    if (urls.isEmpty) {
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
  Future<String> getWeddingOwnerName(String uid) async {
    final data =
        await FirebaseFirestore.instance.collection('owners').doc(uid).get();

    return data['name'];
  }
}
