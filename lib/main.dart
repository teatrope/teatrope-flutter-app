import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:teatrope_flutter_app/core/ui/theme.dart';
import 'package:teatrope_flutter_app/core/token/token_storage.dart';

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

// Admin
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_bloc.dart';
import 'package:teatrope_flutter_app/features/admin/presentation/blocs/admin_event.dart';

// Main
import 'package:teatrope_flutter_app/features/main/main_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dio = Dio();

  runApp(
    MultiBlocProvider(
      providers: [
        // Sign in
        BlocProvider(create: (_) => SigninBloc(authService: AuthService())),

        // Favorites
        BlocProvider(
          create: (_) => FavoriteBloc(
            repository: FavoriteRepositoryImpl(dao: FavoriteDao()),
          )..add(const LoadFavorites()),
        ),

        // Home
        BlocProvider(
          create: (_) =>
              HomeBloc(service: ObraService())
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

        // Admin
        BlocProvider(
          create: (_) =>
              AdminBloc(obraService: ObraService())..add(const LoadTheaters()),
        ),
      ],
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  final MaterialTheme theme = MaterialTheme(TextTheme());
  final TokenStorage _tokenStorage = TokenStorage();
  bool _isAuthenticated = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    final token = await _tokenStorage.read();
    setState(() {
      _isAuthenticated = token != null && token.isNotEmpty;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Container(
            decoration: const BoxDecoration(
              gradient: MaterialTheme.darkLinearGradient,
            ),
            child: const Center(child: CircularProgressIndicator()),
          ),
        ),
      );
    }

    return MaterialApp(
      theme: theme.light(),
      darkTheme: theme.dark(),
      themeMode: ThemeMode.dark, // Force dark theme
      debugShowCheckedModeBanner: false,
      routes: {
        '/notifications': (_) => BlocProvider(
          create: (_) =>
              NotificationsBloc(service: NotificationsService())
                ..add(const LoadNotifications()),
          child: const NotificationsPage(),
        ),
      },
      home: _isAuthenticated
          ? const MainPage()
          : const Scaffold(body: SafeArea(child: SignUpPage())),
    );
  }
}
