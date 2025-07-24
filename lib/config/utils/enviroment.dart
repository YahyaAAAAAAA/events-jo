import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static Future<void> load() async {
    if (kDebugMode) {
      await dotenv.load(fileName: ".env");
    }
  }

  static String get apiKeyWeb => kDebugMode
      ? dotenv.env['APIKEY_WEB'] ?? ''
      : const String.fromEnvironment('APIKEY_WEB');

  static String get apiKeyAndroid => kDebugMode
      ? dotenv.env['APIKEY_ANDROID'] ?? ''
      : const String.fromEnvironment('APIKEY_ANDROID');

  static String get apiKeyIos => kDebugMode
      ? dotenv.env['APIKEY_IOS'] ?? ''
      : const String.fromEnvironment('APIKEY_IOS');

  static String get apiKeyMac => kDebugMode
      ? dotenv.env['APIKEY_MAC'] ?? ''
      : const String.fromEnvironment('APIKEY_MAC');

  static String get apiKeyWind => kDebugMode
      ? dotenv.env['APIKEY_WIND'] ?? ''
      : const String.fromEnvironment('APIKEY_WIND');

  static String get imgApiKey => kDebugMode
      ? dotenv.env['IMG_API_KEY'] ?? ''
      : const String.fromEnvironment('IMG_API_KEY');

  static String get imgApiSecret => kDebugMode
      ? dotenv.env['IMG_API_SECRET'] ?? ''
      : const String.fromEnvironment('IMG_API_SECRET');

  static String get imgCloudName => kDebugMode
      ? dotenv.env['IMG_CLOUD_NAME'] ?? ''
      : const String.fromEnvironment('IMG_CLOUD_NAME');

  static String get appEmail => kDebugMode
      ? dotenv.env['APP_EMAIL'] ?? ''
      : const String.fromEnvironment('APP_EMAIL');
}
