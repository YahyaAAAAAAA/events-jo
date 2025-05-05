abstract class StripeConnectStates {}

class StripeConnectInit extends StripeConnectStates {}

class StripeConnected extends StripeConnectStates {
  final String status;

  StripeConnected(this.status);
}

//first time owner
class StripeNotConnected extends StripeConnectStates {}

//owner started onboarding but didn't finish
class StripeNotCompleted extends StripeConnectStates {}

class StripeConnectError extends StripeConnectStates {
  final String message;

  StripeConnectError(this.message);
}
