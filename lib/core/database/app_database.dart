import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class AppDatabase {
  AppDatabase._();
  static final AppDatabase _instance = AppDatabase._();
  factory AppDatabase() => _instance;

  Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final String path = join(await getDatabasesPath(), 'teatrope.db');
    return openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE obras_favorites (
            id TEXT PRIMARY KEY,
            nombre TEXT,
            descripcion TEXT,
            calle TEXT,
            distrito TEXT,
            latitud REAL,
            longitud REAL,
            image_url TEXT,
            genero TEXT
          )
        ''');
      },
    );
  }
}
