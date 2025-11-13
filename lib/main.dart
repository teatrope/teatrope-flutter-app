import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:teatrope_flutter_app/core/ui/theme.dart';

import 'package:teatrope_flutter_app/features/auth/data/auth_service.dart';
import 'package:teatrope_flutter_app/features/auth/pages/signup_page.dart';
import 'package:teatrope_flutter_app/features/auth/presentation/blocs/signin_bloc.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/blocs/favorite_event.dart';

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

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => SigninBloc(authService: AuthService())),
        BlocProvider(
          create: (_) => FavoriteBloc(
            repository: FavoriteRepositoryImpl(dao: FavoriteDao()),
          )..add(const LoadFavorites()),
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
      create: (_) => HomeBloc(service: ObraService())
        ..add(const GetObrasByGenre(genre: GenresType.all)),
      child: MaterialApp(
        theme: theme.light(),
        darkTheme: theme.dark(),
        debugShowCheckedModeBanner: false,
        routes: {
          '/notifications': (_) => BlocProvider(
                create: (_) => NotificationsBloc(service: NotificationsService())
                  ..add(const LoadNotifications()),
                child: const NotificationsPage(),
              ),
          // Puedes registrar aquí también la página de favoritos si la tienes.
        },
        home: const Scaffold(body: SafeArea(child: SignUpPage())),
      ),
    );
  }
}
