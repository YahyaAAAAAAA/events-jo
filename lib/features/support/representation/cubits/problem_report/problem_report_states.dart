abstract class ProblemReportStates {}

class ProblemReportInitial extends ProblemReportStates {}

class ProblemReportLoading extends ProblemReportStates {}

class ProblemReportLoaded extends ProblemReportStates {
  ProblemReportLoaded();
}

class ProblemReportError extends ProblemReportStates {
  final String message;

  ProblemReportError(this.message);
}
