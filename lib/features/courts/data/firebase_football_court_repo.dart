import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/courts/domain/models/football_court.dart';
import 'package:events_jo/features/courts/domain/repo/football_court_repo.dart';

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
