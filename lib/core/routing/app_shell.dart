import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  const AppShell({
    required this.child,
    required this.location,
    super.key,
  });

  final Widget child;
  final String location;

  int get _currentIndex {
    if (location.startsWith('/menu')) return 1;
    if (location.startsWith('/cart') || location.startsWith('/tracking')) return 2;
    if (location.startsWith('/favorites')) return 3;
    if (location.startsWith('/profile')) return 4;
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: NavigationBar(
        height: 82,
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          final path = switch (index) {
            0 => '/home',
            1 => '/menu',
            2 => '/cart',
            3 => '/favorites',
            _ => '/profile',
          };
          context.go(path);
        },
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_rounded), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.restaurant_rounded), label: 'Menu'),
          NavigationDestination(icon: Icon(Icons.shopping_cart_rounded), label: 'Cart'),
          NavigationDestination(icon: Icon(Icons.favorite_rounded), label: 'Favorites'),
          NavigationDestination(icon: Icon(Icons.person_rounded), label: 'Profile'),
        ],
      ),
    );
  }
}
