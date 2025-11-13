import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_event.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_state.dart';
import 'package:teatrope_flutter_app/features/favorites/domain/favorite_repository.dart';


class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final FavoriteRepository repository;

  FavoriteBloc({required this.repository}) : super(const FavoriteState()) {
    on<ToggleFavorite>(_onToggle);
    on<LoadFavorites>(_onLoad);
  }

  Future<void> _onToggle(ToggleFavorite event, Emitter<FavoriteState> emit) async {
    final isFav = await repository.isFavorite(event.obra.id);
    if (isFav) {
      await repository.delete(event.obra.id);
    } else {
      await repository.insert(event.obra);
    }
    final updated = await repository.fetchAll();
    emit(state.copyWith(obras: updated));
  }

  Future<void> _onLoad(LoadFavorites event, Emitter<FavoriteState> emit) async {
    final list = await repository.fetchAll();
    emit(state.copyWith(obras: list));
  }
}
