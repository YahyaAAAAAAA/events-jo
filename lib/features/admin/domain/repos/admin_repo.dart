import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/auth/domain/entities/app_user.dart';
import 'package:events_jo/features/events/shared/domain/models/football_court.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_drink.dart';
import 'package:events_jo/features/events/shared/domain/models/wedding_venue_meal.dart';
import 'package:events_jo/features/order/domain/models/e_order.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';

abstract class AdminRepo {
  Stream<QuerySnapshot<Map<String, dynamic>>>
      getUnapprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedWeddingVenuesStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getUnapprovedCourtsStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getApprovedCourtsStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllUsersStream();

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllOwnersStream();

  Stream<List<AppUser>> getAllOnlineUsersStream();

  Stream<List<AppUser>> getAllOnlineOwnersStream();

  Stream<WeddingVenue?> getVenueStream(String id);

  Stream<FootballCourt?> getCourtStream(String id);

  Stream<List<WeddingVenueMeal>> getMealsStream(String id);

  Stream<List<WeddingVenueDrink>> getDrinksStream(String id);

  Stream<AppUser?> getUserStream(String id);

  Stream<AppUser?> getOwnerStream(String id);

  Future<void> approveVenue(String id);

  Future<void> suspendVenue(String id);

  Future<void> denyVenue(String id, List<dynamic> urls);

  Future<void> lockVenue(String id);

  Future<void> unlockVenue(String id);

  Future<void> approveCourt(String id);

  Future<void> suspendCourt(String id);

  Future<void> denyCourt(String id, List<dynamic> urls);

  Future<void> lockCourt(String id);

  Future<void> unlockCourt(String id);

  Future<void> deleteImagesFromServer(List<dynamic> urls);

  Stream<List<EOrder>> getOrdersStream();

  Future<void> refund({
    required String paymentIntentId,
    required String orderId,
    required String cancelledBy,
    required double amount,
  });

  Future<void> transfer({
    required String stripeAccountId,
    required String orderId,
    required double amount,
  });

  Future<void> getBalance();

  Future<void> getPayouts();

  String generateUniqueId();

  Future<List<ProblemReport>> getProblems();

  Future<void> checkProblem(ProblemReport problem);

  //! DEPRECATED
  Future<String> getWeddingOwnerName(String uid);
}
