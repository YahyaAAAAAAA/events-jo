import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';

abstract class AdminRepo {
  Stream<List<WeddingVenue>> getUnapprovedWeddingVenuesStream();

  Stream<List<WeddingVenue>> getApprovedWeddingVenuesStream();

  Stream<List<AppUser>> getAllUsersStream();

  Stream<List<AppUser>> getAllOwnersStream();

  Future<void> approveVenue(String id);

  Future<void> suspendVenue(String id);

  Future<void> denyVenue(String id, List<dynamic> urls);

  Future<void> deleteImagesFromServer(List<dynamic> urls);

  //! DEPRECATED
  Future<String> getWeddingOwnerName(String uid);
}
