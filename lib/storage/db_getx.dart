import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DbGetx {
  static final DbGetx _instance = DbGetx._internal();
  late Database _database;

  factory DbGetx() {
    return _instance;
  }

  Database get database => _database;

  DbGetx._internal();

  Future<void> initDb() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, 'app_db.sql');
    _database = await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (db, version) async {
        db.execute('CREATE TABLE notes('
            'id INTEGER PRIMARY KEY AUTOINCREMENT,'
            'content TEXT'
            ')');
      },
      onUpgrade: (db, oldVersion, newVersion) {},
      onDowngrade: (db, oldVersion, newVersion) {},
    );
  }
}
