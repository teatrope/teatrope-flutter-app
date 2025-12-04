// features/home/presentation/blocs/home_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/home/data/obra_service.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_event.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final ObraService service;
  final TokenStorage _tokenStorage;

  HomeBloc({required this.service, TokenStorage? tokenStorage})
    : _tokenStorage = tokenStorage ?? TokenStorage(),
      super(const HomeState()) {
    on<GetObrasByGenre>(_getObrasByGenre);
    on<GetTheaters>(_getTheaters);
  }

  FutureOr<void> _getObrasByGenre(
    GetObrasByGenre event,
    Emitter<HomeState> emit,
  ) async {
    // si quieres evitar refetch al tocar el mismo chip:
    if (state.selectedGenre == event.genre && state.obras.isNotEmpty) return;

    emit(state.copyWith(status: Status.loading, selectedGenre: event.genre));

    try {
      final token = await _tokenStorage.read();
      if (token == null || token.isEmpty) {
        throw Exception('No autenticado. Inicia sesión.');
      }

      // Si es "all" o "TODOS", no pasar género para traer todas las obras
      final genero = event.genre == GenresType.all ? null : event.genre.label;

      final obras = await service.getObras(
        genero: genero, // null para todas, o el género específico
        token: token,
      );

      emit(state.copyWith(status: Status.success, obras: obras));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }

  FutureOr<void> _getTheaters(
    GetTheaters event,
    Emitter<HomeState> emit,
  ) async {
    if (state.theaters.isNotEmpty) return;

    emit(state.copyWith(status: Status.loading));

    try {
      final token = await _tokenStorage.read();
      if (token == null || token.isEmpty) {
        throw Exception('No autenticado. Inicia sesión.');
      }

      final theaters = await service.getTheaters(token: token);

      // Extraer distritos únicos y ordenarlos
      final districts = theaters.map((t) => t.distrito).toSet().toList()
        ..sort();
      // Agregar opción 'All' al inicio
      districts.insert(0, 'All');

      emit(
        state.copyWith(
          status: Status.success,
          theaters: theaters,
          districts: districts,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}
