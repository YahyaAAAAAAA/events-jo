import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_drink.dart';
import 'package:events_jo/features/weddings/domain/entities/wedding_venue_meal.dart';

abstract class AdminRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOwnersStream();

  Stream<List<AppUser>> getAllOnlineUsersStream();

  Stream<List<AppUser>> getAllOnlineOwnersStream();

  Stream<WeddingVenue?> getVenueStream(String id);

  Stream<List<WeddingVenueMeal>> getMealsStream(String id);

  Stream<List<WeddingVenueDrink>> getDrinksStream(String id);

  Stream<AppUser?> getUserStream(String id);

  Stream<AppUser?> getOwnerStream(String id);

  Future<void> approveVenue(String id);

  Future<void> suspendVenue(String id);

  Future<void> denyVenue(String id, List<dynamic> urls);

  Future<void> lockVenue(String id);

  Future<void> unlockVenue(String id);

  Future<void> deleteImagesFromServer(List<dynamic> urls);

  String generateUniqueId();

  //! DEPRECATED
  Future<String> getWeddingOwnerName(String uid);
}
