import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import '../../data/notifications_service.dart';
import 'notifications_event.dart';
import 'notifications_state.dart';

class NotificationsBloc extends Bloc<NotificationsEvent, NotificationsState> {
  final NotificationsService service;
  final TokenStorage _tokenStorage;

  NotificationsBloc({required this.service, TokenStorage? tokenStorage})
    : _tokenStorage = tokenStorage ?? TokenStorage(),
      super(const NotificationsState()) {
    on<LoadNotifications>(_onLoad);
    on<RefreshNotifications>((e, emit) => add(const LoadNotifications()));
  }

  FutureOr<void> _onLoad(
    LoadNotifications event,
    Emitter<NotificationsState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null || token.isEmpty) {
        throw Exception(
          'No autenticado. Inicia sesión para ver tus notificaciones.',
        );
      }

      final notifications = await service.getNotifications(token: token);
      emit(
        state.copyWith(status: Status.success, notifications: notifications),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, error: e.toString()));
    }
  }
}
