import 'package:teatrope_flutter_app/features/home/domain/Obra.dart';

class FavoriteState {
  final List<Obra> obras;
  const FavoriteState({this.obras = const []});

  FavoriteState copyWith({List<Obra>? obras}) => FavoriteState(obras: obras ?? this.obras);
}
