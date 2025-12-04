import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';
import 'package:teatrope_flutter_app/features/favorites/data/favorite_dao.dart';
import 'package:teatrope_flutter_app/features/favorites/domain/favorite_repository.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteDao dao;
  const FavoriteRepositoryImpl({required this.dao});

  @override
  Future<void> insert(Obra obra) => dao.insert(obra);

  @override
  Future<void> delete(String id) => dao.delete(id);

  @override
  Future<List<Obra>> fetchAll() => dao.fetchAll();

  @override
  Future<bool> isFavorite(String id) => dao.isFavorite(id);
}
