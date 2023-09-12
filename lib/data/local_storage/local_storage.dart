import 'package:flutter/foundation.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../domain/models/custom_blue_point_model.dart';
import '../../domain/models/custom_wifi_point_model.dart';
import '../../presentation/utils/constants.dart';

final class LocalStorage {
  static Database? _database;

  Future<Database?> get database async {
    if (_database != null) return _database!;

    _database = await _initDatabase();
    return _database;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'wifi_database.db');
    return await openDatabase(path, version: 1, onCreate: _createDatabase);
  }

  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tableNameWifi(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        ssid TEXT,
        bssid TEXT,
        capabilities TEXT,
        standard INTEGER,
        level INTEGER,
        channelWidth INTEGER,
        frequency INTEGER,
        centerFrequency0 INTEGER,
        centerFrequency1 INTEGER,
        timestamp INTEGER,
        isPasspoint INTEGER,
        operatorFriendlyName TEXT,
        venueName TEXT,
        is80211mcResponder INTEGER
      )
    ''');
    await db.execute('''
CREATE TABLE $tableNameBlue(
  id INTEGER PRIMARY KEY AUTOINCREMENT,
  remoteId TEXT,
  localName TEXT,
  type TEXT,
  rssi INTEGER
)
    ''');
  }

  Future<void> saveToCacheWifi(
      List<CustomWifiPointModel> customWifiPoints) async {
    final Database? db = await database;
    try {
      for (final CustomWifiPointModel customWifiPoint in customWifiPoints) {
        final List<Map<String, Object?>>? existingRecord = await db?.query(
          tableNameWifi,
          where: 'bssid = ?',
          whereArgs: [customWifiPoint.bssid],
        );

        if (existingRecord!.isNotEmpty) {
          await db?.update(
            tableNameWifi,
            customWifiPoint.toMap(),
            where: 'bssid = ?',
            whereArgs: [customWifiPoint.bssid],
          );
        } else {
          await db?.insert(tableNameWifi, customWifiPoint.toMap());
        }
      }
    } catch (e) {
      if (kDebugMode) {
        print('saveToCacheWifie===========>$e');
      }
    }
  }

  Future<
      ({
        String? error,
        List<CustomWifiPointModel> getList,
        bool isSuccess,
      })> getFromCacheWifi() async {
    try {
      final Database? db = await database;

      final List<Map<String, Object?>>? maps = await db?.query(tableNameWifi);

      return (
        isSuccess: true,
        getList: List.generate(maps!.length, (i) {
          return CustomWifiPointModel.fromMap(maps[i]);
        }),
        error: null,
      );
    } on Exception catch (e) {
      return (
        isSuccess: false,
        getList: <CustomWifiPointModel>[],
        error: 'Error Storage => $e',
      );
    }
  }

  Future<void> saveToCacheBlue(
      List<CustomBluePointModel> customBluePoints) async {
final Database? db = await database;
    for (final CustomBluePointModel customBluePoint in customBluePoints) {
      try {
        if (customBluePoint.localName.isNotEmpty) {
          final List<Map<String, Object?>>? existingRecord = await db?.query(
            tableNameBlue,
            where: 'remoteId = ?',
            whereArgs: [customBluePoint.remoteId],
          );
          if (existingRecord!.isNotEmpty) {
            await db?.update(
              tableNameBlue,
              customBluePoint.toMap(),
              where: 'remoteId = ?',
              whereArgs: [customBluePoint.remoteId],
            );
          } else {
            await db?.insert(tableNameBlue, customBluePoint.toMap());
          }
        }
      } on Exception catch (e) {
        if (kDebugMode) {
          print('saveToCacheBlue===========>$e');
        }
      }
    }
  }

  Future<
      ({
        String? error,
        List<CustomBluePointModel> getList,
        bool isSuccess,
      })> getFromCacheBlue() async {
    try {
      final Database? db = await database;

      final List<Map<String, Object?>>? maps = await db?.query(tableNameBlue);
      return (
        isSuccess: true,
        getList: maps!.map((e) => CustomBluePointModel.fromMap(e)).toList(),
        error: null,
      );
    } catch (e) {
      return (
        isSuccess: false,
        getList: <CustomBluePointModel>[],
        error: 'Error Storage => $e',
      );
    }
  }
}
