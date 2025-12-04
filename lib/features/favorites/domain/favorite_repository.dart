import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

abstract class FavoriteRepository {
  Future<void> insert(Obra obra);
  Future<void> delete(String id);
  Future<List<Obra>> fetchAll();
  Future<bool> isFavorite(String id);
}
