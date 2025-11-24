// lib/features/main_page.dart  (o donde lo tengas)

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';

import 'package:teatrope_flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/pages/favorite_list_page.dart';

// PROFILE
import 'package:teatrope_flutter_app/features/profile/presentation/pages/profile_page.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_bloc.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/blocs/profile_event.dart';
import 'package:teatrope_flutter_app/features/profile/data/profile_repository_impl.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/datasource/profile_remote_ds.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = [
    const HomePage(),
    const ComingSoonPage(),
    const FavoriteListPage(),

    // 👉 Pestaña de PROFILE envuelta con su BlocProvider
    BlocProvider(
      create: (context) => ProfileBloc(
        repository: ProfileRepositoryImpl(
          remote: ProfileRemoteDataSource(Dio()),
        ),
      )..add(const LoadProfile()),
      child: const ProfilePage(),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: _pages,
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.local_movies_outlined),
            activeIcon: Icon(Icons.local_movies),
            label: 'Billboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule_outlined),
            activeIcon: Icon(Icons.schedule),
            label: 'Coming soon',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite_outline),
            activeIcon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            activeIcon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Puedes dejar este placeholder aquí o moverlo a su propio archivo
class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Coming soon'),
    );
  }
}
