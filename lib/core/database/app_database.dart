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
      version: 2, // Increment version to trigger migration
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE obras_favorites (
            id TEXT NOT NULL,
            user_id TEXT NOT NULL,
            nombre TEXT,
            descripcion TEXT,
            calle TEXT,
            distrito TEXT,
            latitud REAL,
            longitud REAL,
            image_url TEXT,
            genero TEXT,
            PRIMARY KEY (id, user_id)
          )
        ''');
        await db.execute('''
          CREATE INDEX idx_user_id ON obras_favorites(user_id)
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          // Migrate existing data to new schema with user_id
          await db.execute('''
            CREATE TABLE obras_favorites_new (
              id TEXT NOT NULL,
              user_id TEXT NOT NULL,
              nombre TEXT,
              descripcion TEXT,
              calle TEXT,
              distrito TEXT,
              latitud REAL,
              longitud REAL,
              image_url TEXT,
              genero TEXT,
              PRIMARY KEY (id, user_id)
            )
          ''');
          // Copy existing data with a default user_id (you might want to handle this differently)
          await db.execute('''
            INSERT INTO obras_favorites_new 
            SELECT id, 'default' as user_id, nombre, descripcion, calle, distrito, latitud, longitud, image_url, genero
            FROM obras_favorites
          ''');
          await db.execute('DROP TABLE obras_favorites');
          await db.execute('ALTER TABLE obras_favorites_new RENAME TO obras_favorites');
          await db.execute('''
            CREATE INDEX idx_user_id ON obras_favorites(user_id)
          ''');
        }
      },
    );
  }
}
