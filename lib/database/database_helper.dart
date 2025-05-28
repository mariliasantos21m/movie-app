import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';

class DatabaseHelper {
  Future<Database> initDb() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'movies.db');

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE age_ranges(
        id INTERGER PRIMARY KEY AUTOINCREMENT,
        name TEXT, 
        value INTEGER
      );

      CREATE TABLE movies(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT,
        genres TEXT,
        url_image TEXT,
        age_range_id INTEGER,
        duration TEXT,
        rating REAL,
        year INTEGER,
        description TEXT,
        FOREIGN KEY (age_range_id) REFERENCES age_ranges(id)
      )
    ''');

    await db.insert('age_ranges', {'name': 'Livre', 'value': 0});
    await db.insert('age_ranges', {'name': '10', 'value': 10});
    await db.insert('age_ranges', {'name': '12', 'value': 12});
    await db.insert('age_ranges', {'name': '14', 'value': 14});
    await db.insert('age_ranges', {'name': '16', 'value': 16});
    await db.insert('age_ranges', {'name': '18', 'value': 18});
  }
}
