import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class AdminRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOwnersStream();

  Stream<List<AppUser>> getAllOnlineUsersStream();

  Stream<List<AppUser>> getAllOnlineOwnersStream();

  Stream<WeddingVenue?> getVenueStream(String id);

  Stream<AppUser?> getUserStream(String id);

  Stream<AppUser?> getOwnerStream(String id);

  Future<void> approveVenue(String id);

  Future<void> suspendVenue(String id);

  Future<void> denyVenue(String id, List<dynamic> urls);

  Future<void> deleteImagesFromServer(List<dynamic> urls);

  String generateUniqueId();

  //! DEPRECATED
  Future<String> getWeddingOwnerName(String uid);
}
