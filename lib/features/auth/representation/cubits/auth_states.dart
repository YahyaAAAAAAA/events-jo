// Auth States

import 'package:events_jo/features/auth/domain/entities/app_user.dart';

abstract class AuthStates {}

// initial state
class AuthInitial extends AuthStates {}

// loading..
class AuthLoading extends AuthStates {
  final String? message;
  AuthLoading({this.message});
}

// authenticated
class Authenticated extends AuthStates {
  final AppUser user;
  Authenticated(this.user);
}

// unauthenticated
class Unauthenticated extends AuthStates {}

// errors..
class AuthError extends AuthStates {
  final String message;
  AuthError(this.message);
}
