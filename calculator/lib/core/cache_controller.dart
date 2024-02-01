import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  /// shared preferences helps me to cache some things
  static late SharedPreferences sharedPreferences;

  static init() async {
    sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData({
    required String key,
    required double value,
  }) async {
     await sharedPreferences.setDouble(key, value);
  }

  static double? getData({
    required String key,
  }) {
    return sharedPreferences.getDouble(key);
  }

  static List<String> getKeys() {
    return sharedPreferences.getKeys().toList();
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await sharedPreferences.remove(key);
  }
}
