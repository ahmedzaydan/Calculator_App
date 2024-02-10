import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  /// shared preferences helps me to cache some things
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<dynamic> saveData(String key, dynamic value) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }
    if (value is int) {
      return await _sharedPreferences.setInt(key, value);
    }
    if (value is double) {
      return await _sharedPreferences.setDouble(key, value);
    }
    if (value is bool) {
      return await _sharedPreferences.setBool(key, value);
    }
  }

  static double? getDoubleData(String key) {
    return _sharedPreferences.getDouble(key);
  }

  static bool? getBoolData(String key) {
    return _sharedPreferences.getBool(key);
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
