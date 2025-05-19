import 'package:events_jo/features/support/domain/models/problem_report.dart';

abstract class ProblemReportRepo {
  Future<void> addProblem(ProblemReport problem);
}
