import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'package:teatrope_flutter_app/core/enums/status.dart';
import 'package:teatrope_flutter_app/features/auth/data/auth_service.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_event.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_state.dart';

class SigninBloc extends Bloc<SigninEvent, SigninState> {
  final AuthService authService;

  SigninBloc({required this.authService}) : super(SigninState()) {
    on<OnEmailChanged>(
          (event, emit) => emit(state.copyWith(email: event.email)),
    );
    on<OnPasswordChanged>(
          (event, emit) => emit(state.copyWith(password: event.password)),
    );

    on<Signin>(_signin);
  }

  FutureOr<void> _signin(Signin event, Emitter<SigninState> emit) async {
    emit(state.copyWith(status: Status.loading, message: null));

    try {
      // 1) Login en la API (aquí dentro ya guardas el token en TokenStorage)
      await authService.signIn(state.email, state.password);

      // 2) Guardar el email Y la contraseña con la que se logueó el usuario
      //    (SOLO para este proyecto; en producción esto es mala práctica).
      final sp = await SharedPreferences.getInstance();
      await sp.setString('user_email', state.email);
      await sp.setString('user_password', state.password);

      // 3) Éxito
      emit(state.copyWith(status: Status.success));
    } catch (e) {
      emit(
        state.copyWith(
          status: Status.failure,
          message: e.toString(),
        ),
      );
    }
  }
}
