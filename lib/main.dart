import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/features/auth/data/auth_service.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signup_page.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_bloc.dart';
import 'package:teatrope_flutter_app/features/home/data/obra_service.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_event.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_state.dart';


void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => SigninBloc(authService: AuthService()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
  final MaterialTheme theme = MaterialTheme(TextTheme());
      return BlocProvider(
        create: (context) => 
        HomeBloc(service: ObraService())
        ..add(const GetObrasByGenre(genre: GenresType.all)),
      child: MaterialApp(
        theme: theme.light(),
        darkTheme: theme.dark(),
        debugShowCheckedModeBanner: false,
        home: Scaffold(body: SafeArea (child: SignUpPage())),
      ),
      );
  }
}
