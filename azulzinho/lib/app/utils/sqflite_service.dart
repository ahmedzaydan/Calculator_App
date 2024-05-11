import 'package:azulzinho/app/resources/strings_manager.dart';
import 'package:azulzinho/app/utils/functions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class SqfliteService {
  static const String databaseName = 'azulzinho.db';
  static late Database _database;

  static Future<void> initialize() async {
    // Get a location using getDatabasesPath
    var databasesPath = await getDatabasesPath();
    String path = databasesPath + databaseName;

    await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        kprint('Database created');
        _database = db;
        String msg1 = await _createPersonsTable();
        String msg2 = await _createKitsTable();

        kprint(msg1);
        kprint(msg2);
      },
      onOpen: (Database db) {
        kprint('Database opened');
        _database = db;
      },
    );
  }

  static Future<String> _createPersonsTable() async {
    String? message;

    await _database.transaction((txn) async {
      await txn.execute(
        '''CREATE TABLE ${PersonsStrings.tableName} (
              id INTEGER PRIMARY KEY, 
              name TEXT, 
              percentage REAL, 
              shareValue REAL)''',
      ).catchError((e) {
        message = 'Error in execute while creating persons table: $e';
      });
    }).catchError((e) {
      message = 'Error in transaction while creating persons table: $e';
    });

    return message ?? 'Persons table created';
  }

  static Future<String> _createKitsTable() async {
    String? message;

    await _database.transaction((txn) async {
      await txn.execute(
        '''CREATE TABLE ${KitsStrings.tableName} (
              id INTEGER PRIMARY KEY, 
              name TEXT, 
              value REAL,
              isChecked INTEGER,
              isExpired INTEGER,
              startDate TEXT,
              endDate TEXT)''',
      ).catchError((e) {
        message = 'Error in execute while creating kits table: $e';
      });
    }).catchError((e) {
      message = 'Error in transaction while creating kits table: $e';
    });

    return message ?? 'Kits table created';
  }

  static Future<int> insertRow(String sql) async {
    int id = -1;
    try {
      await _database.transaction((txn) async {
        id = await txn.rawInsert(sql);
      });

      return id;
    } catch (e) {
      kprint('Error in insertData: \n$e');
    }

    return id;
  }

  // function check if row exists by
  // returning the number of rows matches the condition
  static Future<List<Map<String, Object?>>> getMatchedRecords({
    required String tableName,
    required String condition,
  }) async {
    List<Map<String, Object?>> queryResult = [];
    try {
      String sql = '''SELECT * FROM $tableName WHERE $condition''';

      await _database.transaction((txn) async {
        queryResult = await txn.rawQuery(sql);
      });

      kprint('Query result: $queryResult');
      return queryResult;
    } catch (e) {
      kprint('Error in getMatchedRows: \n$e');
    }

    return queryResult;
  }

  // static Future<List<Map<String, dynamic>>> getData({
  //   required String tableName,
  //   required int id,
  // }) {}

  static Future<List<Map<String, Object?>>> getRecords(
    String tableName,
  ) async {
    List<Map<String, Object?>> records = [];

    await _database.transaction((txn) async {
      records = await txn.query(tableName);
    });

    return records;
  }

  static Future<bool> updateRecord({
    required String tableName,
    required String data,
    required int id,
  }) async {
    bool isUpdated = false;
    try {
      String sql = '''UPDATE $tableName SET $data WHERE id = $id''';
      await _database.transaction((txn) async {
        isUpdated = await txn.rawUpdate(sql) > 0;
      });

      return isUpdated;
    } catch (e) {
      kprint('Error in updateRecord: \n$e');
      return isUpdated;
    }
  }

  static Future<bool> deleteRecord({
    required String tableName,
    required int id,
  }) async {
    bool isDeleted = false;
    try {
      String sql = '''DELETE FROM $tableName WHERE id = $id''';
      await _database.transaction((txn) async {
        isDeleted = await txn.rawDelete(sql) > 0;
      });

      return isDeleted;
    } catch (e) {
      kprint('Error in deleteRecord: \n$e');
      return isDeleted;
    }
  }
}

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
