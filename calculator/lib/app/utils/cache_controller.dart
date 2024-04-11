import 'package:shared_preferences/shared_preferences.dart';

class Prefs {
  static late SharedPreferences _sharedPreferences;

  static init() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> save(String key, dynamic value) async {
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

  static String? getString(String key) {
    return _sharedPreferences.getString(key);
  }

  static List<String>? getStringList(String key) {
    return _sharedPreferences.getStringList(key);
  }

  static int? getInt(String key) {
    return _sharedPreferences.getInt(key);
  }

  static double? getDouble(String key) {
    return _sharedPreferences.getDouble(key);
  }

  static bool? getBool(String key) {
    return _sharedPreferences.getBool(key);
  }

  static List<String> getKeys() {
    return _sharedPreferences.getKeys().toList();
  }

  static Future<bool> remove(String key) async {
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
