abstract class SettingsStates {}

class SettingsInitial extends SettingsStates {}

class SettingsLoading extends SettingsStates {}

class SettingsLoaded extends SettingsStates {}

class SettingsError extends SettingsStates {
  final String message;

  SettingsError(this.message);
}
