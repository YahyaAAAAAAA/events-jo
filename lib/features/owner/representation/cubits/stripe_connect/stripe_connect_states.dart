import 'package:events_jo/features/owner/domain/models/stripe_connect.dart';

abstract class StripeConnectStates {}

class StripeConnectInit extends StripeConnectStates {}

class StripeConnectLoading extends StripeConnectStates {}

class StripeConnected extends StripeConnectStates {
  final StripeConnect stripeConnect;

  StripeConnected(this.stripeConnect);
}

class StripeConnectError extends StripeConnectStates {
  final String message;

  StripeConnectError(this.message);
}
