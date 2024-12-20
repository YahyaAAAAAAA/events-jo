abstract class PasswordStates {}

class PasswordInitial extends PasswordStates {}

class PasswordLoading extends PasswordStates {}

class PasswordLoaded extends PasswordStates {}

class PasswordUpdated extends PasswordStates {
  final String message;

  PasswordUpdated(this.message);
}

class PasswordError extends PasswordStates {
  final String message;

  PasswordError(this.message);
}
