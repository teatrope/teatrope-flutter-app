// coming_soon_bloc.dart
import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import '../../data/coming_soon_service.dart';
import 'coming_soon_event.dart';
import 'coming_soon_state.dart';

class ComingSoonBloc extends Bloc<ComingSoonEvent, ComingSoonState> {
  final ComingSoonService service;
  final TokenStorage _tokenStorage;

  ComingSoonBloc({
    required this.service,
    TokenStorage? tokenStorage,
  })  : _tokenStorage = tokenStorage ?? TokenStorage(),
        super(const ComingSoonState()) {
    on<LoadComingSoon>(_onLoad);
    on<RefreshComingSoon>((e, emit) => add(const LoadComingSoon()));
  }

  FutureOr<void> _onLoad(
    LoadComingSoon event,
    Emitter<ComingSoonState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null || token.isEmpty) {
        throw Exception('No autenticado. Inicia sesión para ver próximos estrenos.');
      }

      final obras = await service.getComingSoonObras(token: token);
      emit(state.copyWith(status: Status.success, obras: obras));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, message: e.toString()));
    }
  }
}



