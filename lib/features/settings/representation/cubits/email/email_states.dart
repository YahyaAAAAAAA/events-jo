abstract class EmailStates {}

class EmailInitial extends EmailStates {}

class EmailLoading extends EmailStates {}

class EmailLoaded extends EmailStates {}

class EmailError extends EmailStates {
  final String message;

  EmailError(this.message);
}

class EmailVerificationSent extends EmailStates {
  final String message;

  EmailVerificationSent(this.message);
}
