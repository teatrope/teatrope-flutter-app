import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

abstract class FavoriteEvent {
  const FavoriteEvent();
}

class ToggleFavorite extends FavoriteEvent {
  final Obra obra;
  const ToggleFavorite(this.obra);
}

class LoadFavorites extends FavoriteEvent {
  const LoadFavorites();
}
