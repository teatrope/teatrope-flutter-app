import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/profile/domain/profile_repository.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final ProfileRepository repository;

  ProfileBloc({required this.repository}) : super(ProfileState.initial()) {
    on<LoadProfile>(_onLoadProfile);
    on<RefreshProfile>(_onRefreshProfile);
    on<UpdateProfilePressed>(_onUpdateProfile);
    on<UpdatePreferencesPressed>(_onUpdatePreferences);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoadProfile(
    LoadProfile event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, logoutSuccess: false));

    try {
      final profile = await repository.getProfile();
      final prefs = await repository.getPreferences();

      emit(state.copyWith(
        status: Status.success,
        profile: profile,
        preferences: prefs,
      ));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onRefreshProfile(
    RefreshProfile event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final profile = await repository.getProfile();
      emit(state.copyWith(profile: profile));
    } catch (_) {
      // opcional: manejar error de refresh
    }
  }

  Future<void> _onUpdateProfile(
    UpdateProfilePressed event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading));

    try {
      final updated = await repository.updateProfile(event.updated);
      emit(
        state.copyWith(
          status: Status.success,
          profile: updated,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  Future<void> _onUpdatePreferences(
    UpdatePreferencesPressed event,
    Emitter<ProfileState> emit,
  ) async {
    try {
      final updated = await repository.updatePreferences(event.updated);
      emit(state.copyWith(preferences: updated));
    } catch (_) {
      // si falla, mantenemos las anteriores
    }
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<ProfileState> emit,
  ) async {
    emit(state.copyWith(status: Status.loading, logoutSuccess: false));
    try {
      await repository.logout();
      emit(
        state.copyWith(
          status: Status.success,
          logoutSuccess: true,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }
}
