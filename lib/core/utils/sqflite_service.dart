import 'dart:io';

import 'package:azulzinho/core/utils/functions.dart';
import 'package:azulzinho/themes/strings_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

import 'package:path/path.dart';

class SqfliteService {
  static const String databaseName = 'azulzinho.db';
  static late Database _database;

  static Future<void> initialize() async {
    try {
      // Get the appropriate directory based on platform
      final directory = await getApplicationDocumentsDirectory();

      // Handle Android permissions if needed
      if (Platform.isAndroid) {
        await requestStoragePermission();
      }

      // Create the proper path using path.join
      final path = join(directory.path, databaseName);

      // Initialize database with proper error handling
      _database = await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
          kprint('Database created');
          await _createPersonsTable(db); // Pass the db instance
          await _createKitsTable(db);
        },
        onOpen: (Database db) {
          kprint('Database opened successfully');
        },
      );

      kprint('Database initialized successfully at: $path');
    } catch (e, stackTrace) {
      kprint('Database initialization error: $e');
      kprint('Stack trace: $stackTrace');
      rethrow;
    }
  }

  static Future<String> _createPersonsTable(Database db) async {
    String? message;

    await db.transaction((txn) async {
      await txn.execute(
        '''CREATE TABLE ${PersonsStrings.tableName} (
            id INTEGER PRIMARY KEY, 
            name TEXT, 
            percentage REAL)''',
      ).catchError((e) {
        message = 'Error in execute while creating persons table: $e';
      });
    }).catchError((e) {
      message = 'Error in transaction while creating persons table: $e';
    });

    return message ?? 'Persons table created';
  }

  static Future<String> _createKitsTable(Database db) async {
    String? message;

    await db.transaction((txn) async {
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

  /// function check if row exists by returning the number of rows matches the condition
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
