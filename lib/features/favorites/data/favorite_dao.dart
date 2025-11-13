import 'package:sqflite/sqflite.dart';
import 'package:teatrope_flutter_app/core/database/app_database.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class FavoriteDao {
  static const _table = 'obras_favorites';

  Future<void> insert(Obra obra) async {
    final db = await AppDatabase().database;
    await db.insert(
      _table,
      obra.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase().database;
    await db.delete(_table, where: 'id = ?', whereArgs: [id]);
  }

  Future<List<Obra>> fetchAll() async {
    final db = await AppDatabase().database;
    final maps = await db.query(_table);
    return maps.map((e) => Obra.fromMap(e)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await AppDatabase().database;
    final maps = await db.query(_table, where: 'id = ?', whereArgs: [id], limit: 1);
    return maps.isNotEmpty;
  }
}
