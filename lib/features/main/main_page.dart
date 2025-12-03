// lib/features/main_page.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:teatrope_flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/pages/favorite_list_page.dart';
import 'package:teatrope_flutter_app/features/profile/presentation/pages/profile_page.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/pages/coming_soon_page.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/blocs/coming_soon_bloc.dart';
import 'package:teatrope_flutter_app/features/coming_soon/presentation/blocs/coming_soon_event.dart';
import 'package:teatrope_flutter_app/features/coming_soon/data/coming_soon_service.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: IndexedStack(
          index: _selectedIndex,
          children: [
            const HomePage(),
            BlocProvider(
              create: (_) =>
                  ComingSoonBloc(service: ComingSoonService())
                    ..add(const LoadComingSoon()),
              child: const ComingSoonPage(),
            ),
            const FavoriteListPage(),
            const ProfilePage(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        onTap: (value) => setState(() => _selectedIndex = value),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        backgroundColor: Theme.of(context).colorScheme.surfaceContainerHigh,
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
            label: 'Admin',
          ),
        ],
      ),
    );
  }
}
