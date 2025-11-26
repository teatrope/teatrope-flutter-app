import 'package:sqflite/sqflite.dart';
import 'package:teatrope_flutter_app/core/database/app_database.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class FavoriteDao {
  static const _table = 'obras_favorites';
  final TokenStorage _tokenStorage = TokenStorage();

  Future<String> _getUserId() async {
    // Get user ID from token or use a default
    // In a real app, you'd decode the token or get user ID from auth service
    final token = await _tokenStorage.read();
    if (token == null || token.isEmpty) {
      throw Exception('No autenticado. Inicia sesión para guardar favoritos.');
    }
    // For now, we'll use a hash of the token as user_id
    // In production, you should get the actual user ID from the token or auth service
    return token.substring(0, token.length > 20 ? 20 : token.length);
  }

  Future<void> insert(Obra obra) async {
    final db = await AppDatabase().database;
    final userId = await _getUserId();
    final map = obra.toMap();
    map['user_id'] = userId;
    await db.insert(
      _table,
      map,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> delete(String id) async {
    final db = await AppDatabase().database;
    final userId = await _getUserId();
    await db.delete(
      _table,
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
    );
  }

  Future<List<Obra>> fetchAll() async {
    final db = await AppDatabase().database;
    final userId = await _getUserId();
    final maps = await db.query(
      _table,
      where: 'user_id = ?',
      whereArgs: [userId],
    );
    return maps.map((e) => Obra.fromMap(e)).toList();
  }

  Future<bool> isFavorite(String id) async {
    final db = await AppDatabase().database;
    final userId = await _getUserId();
    final maps = await db.query(
      _table,
      where: 'id = ? AND user_id = ?',
      whereArgs: [id, userId],
      limit: 1,
    );
    return maps.isNotEmpty;
  }
}
