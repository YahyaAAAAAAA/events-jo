import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AdminRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream();

  Stream<List<AppUser>> getAllUsersStream();

  Stream<List<AppUser>> getAllOwnersStream();

  Stream<List<AppUser>> getAllOnlineUsersStream();

  Stream<List<AppUser>> getAllOnlineOwnersStream();

  Future<void> approveVenue(String id);

  Future<void> suspendVenue(String id);

  Future<void> denyVenue(String id, List<dynamic> urls);

  Future<void> deleteImagesFromServer(List<dynamic> urls);

  String generateUniqueId();

  //! DEPRECATED
  Future<String> getWeddingOwnerName(String uid);
}
