import 'package:flutter/material.dart';
import 'package:teatrope_flutter_app/features/home/presentation/pages/home_page.dart';
import 'package:teatrope_flutter_app/features/favorites/presentation/pages/favorite_list_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _selectedIndex = 0;

  late final List<Widget> _pages = const [
    HomePage(),
    ComingSoonPage(),
    FavoriteListPage(),   // ← aquí va tu lista de favoritos
    ProfilePage(),
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

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Coming soon'));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});
  @override
  Widget build(BuildContext context) => const Center(child: Text('Profile'));
}
