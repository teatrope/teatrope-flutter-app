import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_event.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_state.dart';
import 'package:teatrope_flutter_app/features/home/data/obra_service.dart';
import 'package:teatrope_flutter_app/features/home/domain/theater.dart';

class AdminBloc extends Bloc<AdminEvent, AdminState> {
  final ObraService obraService;
  final TokenStorage _tokenStorage = TokenStorage();

  AdminBloc({required this.obraService}) : super(const AdminState()) {
    on<LoadTheaters>(_onLoadTheaters);
    on<SelectTheater>(_onSelectTheater);
    on<LoadTheaterObras>(_onLoadTheaterObras);
    on<EditObra>(_onEditObra);
    on<UpdateObra>(_onUpdateObra);
    on<ClearEditingObra>(_onClearEditingObra);
  }

  Future<void> _onLoadTheaters(
    LoadTheaters event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null) throw Exception('No token found');

      final theaters = await obraService.getTheaters(token: token);

      // Deduplicate theaters by ID
      final uniqueTheaters = <String, Theater>{};
      for (var theater in theaters) {
        uniqueTheaters[theater.id] = theater;
      }

      emit(
        state.copyWith(
          status: Status.success,
          theaters: uniqueTheaters.values.toList(),
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onSelectTheater(
    SelectTheater event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(selectedTheater: event.theater));
    add(LoadTheaterObras(event.theater.id));
  }

  Future<void> _onLoadTheaterObras(
    LoadTheaterObras event,
    Emitter<AdminState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null) throw Exception('No token found');

      // Fetch all obras and filter by theaterId
      // Ideally the API would support filtering by theaterId, but for now we filter client-side
      // based on the assumption that getObras returns all works.
      // If getObras supports filtering, we should use that.
      // Checking ObraService... it supports filtering by genre.
      // We'll fetch all and filter.
      final allObras = await obraService.getObras(token: token);
      final theaterObras = allObras
          .where((o) => o.teatroId == event.theaterId)
          .toList();

      emit(state.copyWith(status: Status.success, obras: theaterObras));
    } catch (e) {
      emit(state.copyWith(status: Status.failure, errorMessage: e.toString()));
    }
  }

  Future<void> _onEditObra(EditObra event, Emitter<AdminState> emit) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null) throw Exception('No token found');

      final obra = await obraService.getObraById(
        id: event.obraId,
        token: token,
      );
      emit(
        state.copyWith(
          updateStatus: Status.initial, // Reset status for UI
          editingObra: obra,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: Status.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdateObra(UpdateObra event, Emitter<AdminState> emit) async {
    emit(state.copyWith(updateStatus: Status.loading));
    try {
      final token = await _tokenStorage.read();
      if (token == null) throw Exception('No token found');

      await obraService.updateObra(
        id: event.obraId,
        data: event.data,
        token: token,
      );

      emit(
        state.copyWith(
          updateStatus: Status.success,
          clearEditingObra: true, // Clear editing obra on success
        ),
      );

      // Refresh list
      if (state.selectedTheater != null) {
        add(LoadTheaterObras(state.selectedTheater!.id));
      }
    } catch (e) {
      emit(
        state.copyWith(
          updateStatus: Status.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  void _onClearEditingObra(ClearEditingObra event, Emitter<AdminState> emit) {
    emit(state.copyWith(clearEditingObra: true));
  }
}
