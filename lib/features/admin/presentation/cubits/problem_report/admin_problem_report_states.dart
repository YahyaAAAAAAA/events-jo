import 'package:events_jo/features/support/domain/models/problem_report.dart';

abstract class AdminProblemReportStates {}

class AdminProblemReportInitial extends AdminProblemReportStates {}

class AdminProblemReportLoading extends AdminProblemReportStates {}

class AdminProblemReportLoaded extends AdminProblemReportStates {
  List<ProblemReport> problems;

  AdminProblemReportLoaded(
    this.problems,
  );
}

class AdminProblemReportError extends AdminProblemReportStates {
  final String message;

  AdminProblemReportError(this.message);
}
