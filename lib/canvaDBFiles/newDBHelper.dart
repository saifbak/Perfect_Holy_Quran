import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {
  static final _databaseName = "MyDatabase.db";
  static final _databaseVersion = 1;

  static final String table = 'AyaBookMark';
  static final String columnId = 'id';
  static final String columnAyatNumber = 'AyatNo';
  static final String columnChapterNo = 'AyatChapterNo';
  static final String columnAyatText = 'AyatText';
  static final String columnAyatTranslation = 'AyatTranslation';
  static final String columnChapterName = 'AyatChapterName';

  static final String notificationTable = 'newNotificationTable';
  static final String idNotification = 'id';
  static final String nameNotification = 'NotificationName';
  static final String hoursNotification = 'NotificationHours';
  static final String minutesNotification = 'NotificationMinutes';

  // make this a singleton class
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  // this opens the database (and creates it if it doesn't exist)
  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path, version: _databaseVersion, onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE $table (
            $columnId INTEGER PRIMARY KEY,
            
            $columnAyatNumber INTEGER NOT NULL,
            
            $columnChapterNo INTEGER NOT NULL,
            
            $columnAyatText TEXT  NOT NULL,
            
            $columnAyatTranslation TEXT  NOT NULL,
            
            $columnChapterName  TEXT  NOT NULL)
          ''');

    await db.execute('''
          CREATE TABLE $notificationTable (
            $idNotification INTEGER PRIMARY KEY,

            $nameNotification TEXT  NOT NULL,
            
            $hoursNotification TEXT  NOT NULL,
            
            $minutesNotification  TEXT  NOT NULL)
          ''');
  }

  // Helper methods

  // Inserts a row in the database where each key in the Map is a column name
  // and the value is the column value. The return value is the id of the
  // inserted row.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  insertData(String ayaNumber, String chapterNo, String ayaText, String ayaTranslation, String chapterName) async {
    final db = await database;
    var maxIdResult = await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM AyaBookMark");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert(
        "INSERT Into AyaBookMark (id,AyatNo, AyatChapterNo, AyatText, AyatTranslation,AyatChapterName )"
        " VALUES (?, ?, ?, ?, ?, ?)",
        [id, ayaNumber, chapterNo, ayaText, ayaTranslation, chapterName]);
    return result;
  }

  Future<int> insertNotification(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(notificationTable, row);
  }

  Future<bool> isAlreadyExist() async {
    Database db = await instance.database;
    var res = await db.query("AyaBookMark");
    return res.length > 0 ? true : false;
  }

  // All of the rows are returned as a list of maps, where each map is
  // a key-value list of columns.
  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  // All of the methods (insert, query, update, delete) can also be done using
  // raw SQL commands. This method uses a raw query to give the row count.
  Future<int> queryRowCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }

    Future<bool> already(String ayaID) async {
    Database db = await instance.database;
    await db.query('SELECT (*) FROM $table WHERE $columnAyatNumber = $ayaID');

    return true;
  }

  // We are assuming here that the id column in the map is set. The other
  // column values will be used to update the row.
  Future<int> update(Map<String, dynamic> row) async {
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(table, row, where: '$columnId = ?', whereArgs: [id]);
  }

  // Deletes the row specified by the id. The number of affected rows is
  // returned. This should be 1 as long as the row exists.
  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnId = ?', whereArgs: [id]);
  }

// Future deleteAllRows() async {
//   var db = await database;
//   return await db.delete("delete from "+ table);
// }
/*

  Future calculateTotal() async {
    var dbClient = await database;
    var result = await dbClient.rawQuery("SELECT SUM($columnDuration) as Total FROM $table");
    return result.toList();
  }

  Future<int> queryOneDayRowCount() async {
    Database db = await instance.database;
    DateTime now = DateTime.now();
    DateTime oneDayAgoFromNow = now.subtract(Duration(days: 1));
    var today = now.millisecondsSinceEpoch;
    var oneDayAgo = oneDayAgoFromNow.millisecondsSinceEpoch;
    return Sqflite.firstIntValue(await db.rawQuery('''SELECT COUNT(*) FROM $table WHERE $columnDate BETWEEN '$oneDayAgo' AND '$today' '''));
  }

  Future<List<Map<String, dynamic>>> queryLastOneDay() async {
    Database dbClient = await database;
    DateTime now = DateTime.now();
    DateTime oneDayAgoFromNow = now.subtract(Duration(days: 1));
    var today = now.millisecondsSinceEpoch;
    var oneDayAgo = oneDayAgoFromNow.millisecondsSinceEpoch;
    var result= await dbClient.rawQuery('''SELECT SUM($columnDuration) as TotalOne FROM $table WHERE $columnDate BETWEEN '$oneDayAgo' AND '$today' ''');
    return result.toList();
  }

  Future<int> querySevenDayRowCount() async {
    Database db = await instance.database;
    DateTime now = DateTime.now();
    DateTime sevenDayAgoFromNow = now.subtract(Duration(days: 7));
    var today = now.millisecondsSinceEpoch;
    var sevenDayAgo = sevenDayAgoFromNow.millisecondsSinceEpoch;
    return Sqflite.firstIntValue(await db.rawQuery('''SELECT COUNT(*) FROM $table WHERE $columnDate BETWEEN '$sevenDayAgo' AND '$today' '''));
  }

  Future<List<Map<String, dynamic>>> queryLastSevenDays() async {
    Database db = await database;
    DateTime now = DateTime.now();
    DateTime sevenDaysAgoFromNow = now.subtract(Duration(days: 7));
    var today = now.millisecondsSinceEpoch;
    var sevenDaysAgo = sevenDaysAgoFromNow.millisecondsSinceEpoch;
    return await db.rawQuery('''SELECT SUM($columnDuration) as TotalSeven FROM $table WHERE $columnDate BETWEEN '$sevenDaysAgo' AND '$today' ''');
  }

  Future<int> queryThirtyDayRowCount() async {
    Database db = await instance.database;
    DateTime now = DateTime.now();
    DateTime thirtyDayAgoFromNow = now.subtract(Duration(days: 30));
    var today = now.millisecondsSinceEpoch;
    var thirtyDayAgo = thirtyDayAgoFromNow.millisecondsSinceEpoch;
    return Sqflite.firstIntValue(await db.rawQuery('''SELECT COUNT(*) FROM $table WHERE $columnDate BETWEEN '$thirtyDayAgo' AND '$today' '''));
  }

  Future<List<Map<String, dynamic>>> queryLastThirtyDays() async {
    Database db = await database;
    DateTime now = DateTime.now();
    DateTime thirtyDaysAgoFromNow = now.subtract(Duration(days: 30));
    var today = now.millisecondsSinceEpoch;
    var thirtyDaysAgo = thirtyDaysAgoFromNow.millisecondsSinceEpoch;
    return await db.rawQuery('''SELECT SUM($columnDuration) as TotalThirty FROM $table WHERE $columnDate BETWEEN '$thirtyDaysAgo' AND '$today' ''');
  }

*/

}
