import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:events_jo/features/support/domain/models/problem_report.dart';
import 'package:events_jo/features/support/domain/repos/problem_report_repo.dart';

class FirebaseProblemReportRepo implements ProblemReportRepo {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;

  @override
  Future<void> addProblem(ProblemReport problem) async {
    final docRef = firebaseFirestore.collection('problems').doc(problem.id);
    await docRef.set(problem.toJson());
  }
}
