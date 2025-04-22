import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/events/courts/domain/models/football_court.dart';
import 'package:events_jo/features/events/courts/domain/repo/football_court_repo.dart';

class FirebaseFootballCourtRepo implements FootballCourtRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<List<FootballCourt>> getAllCourts() async {
    final querySnapshot = await firebaseFirestore
        .collection('courts')
        .where('isApproved', isEqualTo: true)
        .get();

    return querySnapshot.docs
        .map((doc) => FootballCourt.fromJson(doc.data()))
        .toList();
  }

  @override
  Future<FootballCourt?> getCourt(String id) async {
    final docSnapshot =
        await firebaseFirestore.collection('courts').doc(id).get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }

    return FootballCourt.fromJson(docSnapshot.data()!);
  }

  @override
  Future<void> rateVenue({
    required String courtId,
    required String userId,
    required String userName,
    required int userOrdersCount,
    required int rate,
  }) async {
    final docRef = firebaseFirestore.collection('courts').doc(courtId);
    final docSnapshot = await docRef.get();

    if (!docSnapshot.exists || docSnapshot.data() == null) {
      return null;
    }

    final oldRates = List<String>.from(docSnapshot.data()?['rates'] ?? []);
    final newRate = '$rate/$userOrdersCount/$userName/$userId';

    // Check if the user has already rated
    final userRateIndex =
        oldRates.indexWhere((r) => r.split('/').last == userId);

    if (userRateIndex != -1) {
      // Update the existing rate
      oldRates[userRateIndex] = newRate;
    } else {
      // Add the new rate
      oldRates.add(newRate);
    }

    await firebaseFirestore.collection('courts').doc(courtId).update(
      {
        'rates': oldRates,
      },
    );
  }

  @override
  Future<void> approveCourt(String id) async {
    await firebaseFirestore
        .collection('courts')
        .doc(id)
        .update({'isApproved': true});
  }

  @override
  Future<void> suspendCourt(String id) async {
    await firebaseFirestore
        .collection('courts')
        .doc(id)
        .update({'isApproved': false});
  }
}
