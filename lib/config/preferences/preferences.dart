import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  // Write DATA
  static Future<bool> saveBool(String key, bool value) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return await sharedPreferences.setBool(key, value);
  }

  // Read Data
  static Future<bool?>? readBool(String key) async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences.getBool(key);
  }
}
