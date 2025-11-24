import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';

// Auth
import 'package:teatrope_flutter_app/features/auth/data/auth_service.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signup_page.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_bloc.dart';

// Home
import 'package:teatrope_flutter_app/features/home/data/obra_service.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_bloc.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_event.dart';
import 'package:teatrope_flutter_app/features/home/presentation/blocs/home_state.dart';

// Notifications
import 'package:teatrope_flutter_app/features/notifications/data/notifications_service.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/blocs/notifications_bloc.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/blocs/notifications_event.dart';
import 'package:teatrope_flutter_app/features/notifications/presentation/pages/notifications_page.dart';

// Favorites
import 'package:teatrope_flutter_app/features/favorites/data/favorite_dao.dart';
import 'package:teatrope_flutter_app/features/favorites/data/favorite_repository_impl.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_event.dart';

// Profile
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/data/profile_repository_impl.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/datasource/profile_remote_ds.dart';

void main() {
  final dio = Dio();

  runApp(
    MultiBlocProvider(
      providers: [
        // Sign in
        BlocProvider(
          create: (_) => SigninBloc(authService: AuthService()),
        ),

        // Favorites
        BlocProvider(
          create: (_) => FavoriteBloc(
            repository: FavoriteRepositoryImpl(dao: FavoriteDao()),
          )..add(const LoadFavorites()),
        ),

        // Home
        BlocProvider(
          create: (_) => HomeBloc(service: ObraService())
            ..add(const GetObrasByGenre(genre: GenresType.all)),
        ),

        // Profile 👈 AQUI agregamos ProfileBloc global
        BlocProvider(
          create: (_) => ProfileBloc(
            repository: ProfileRepositoryImpl(
              remote: ProfileRemoteDataSource(dio),
            ),
          )..add(const LoadProfile()),
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

    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/notifications': (_) => BlocProvider(
              create: (_) => NotificationsBloc(
                service: NotificationsService(),
              )..add(const LoadNotifications()),
              child: const NotificationsPage(),
            ),
      },
      // luego de signup navegarás a MainPage()
      home: const Scaffold(
        body: SafeArea(
          child: SignUpPage(),
        ),
      ),
    );
  }
}
