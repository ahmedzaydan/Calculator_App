import 'package:shared_preferences/shared_preferences.dart';

class CacheController {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> saveData(String key, dynamic value) async {
    if (value is String) {
      return await _sharedPreferences.setString(key, value);
    }
    if (value is List<String>) {
      return await _sharedPreferences.setStringList(key, value);
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
    return false;
  }

  static String? getStringData(String key) {
    return _sharedPreferences.getString(key);
  }

  static List<String>? getStringListData(String key) {
    return _sharedPreferences.getStringList(key);
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

  static Future<bool> removeData(String key) async {
    return await _sharedPreferences.remove(key);
  }

  static bool checkKey(String key) {
    return _sharedPreferences.containsKey(key);
  }

  // return all stored keys
  static List<String> getAllKeys() {
    return _sharedPreferences.getKeys().toList();
  }
}
