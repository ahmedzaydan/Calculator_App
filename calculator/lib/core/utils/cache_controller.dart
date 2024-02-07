import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  /// shared preferences helps me to cache some things
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveData({
    required String key,
    required double value,
  }) async {
    await _sharedPreferences.setDouble(key, value);
  }

  static double? getData({
    required String key,
  }) {
    return _sharedPreferences.getDouble(key);
  }

  static List<String> getKeys() {
    return _sharedPreferences.getKeys().toList();
  }

  static Future<bool> removeData({
    required String key,
  }) async {
    return await _sharedPreferences.remove(key);
  }

  static bool checkKey({
    required String key,
  }) {
    return _sharedPreferences.containsKey(key);
  }
}
