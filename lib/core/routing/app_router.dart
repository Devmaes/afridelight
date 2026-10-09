import 'package:afridelight/core/routing/app_shell.dart';
import 'package:afridelight/features/cart/presentation/cart_page.dart';
import 'package:afridelight/features/catalog/presentation/home_page.dart';
import 'package:afridelight/features/catalog/presentation/menu_page.dart';
import 'package:afridelight/features/catalog/presentation/product_detail_page.dart';
import 'package:afridelight/features/favorites/presentation/favorites_page.dart';
import 'package:afridelight/features/profile/presentation/profile_page.dart';
import 'package:afridelight/features/tracking/presentation/tracking_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      ShellRoute(
        builder: (context, state, child) =>
            AppShell(location: state.uri.path, child: child),
        routes: [
          GoRoute(path: '/home', pageBuilder: (context, state) => _fadePage(state, const HomePage())),
          GoRoute(path: '/menu', pageBuilder: (context, state) => _fadePage(state, const MenuPage())),
          GoRoute(
            path: '/dish/:id',
            pageBuilder: (context, state) =>
                _slidePage(state, ProductDetailPage(dishId: state.pathParameters['id']!)),
          ),
          GoRoute(path: '/cart', pageBuilder: (context, state) => _fadePage(state, const CartPage())),
          GoRoute(path: '/tracking', pageBuilder: (context, state) => _slidePage(state, const TrackingPage())),
          GoRoute(path: '/favorites', pageBuilder: (context, state) => _fadePage(state, const FavoritesPage())),
          GoRoute(path: '/profile', pageBuilder: (context, state) => _fadePage(state, const ProfilePage())),
        ],
      ),
    ],
  );
});

CustomTransitionPage<void> _fadePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 220),
    transitionsBuilder: (_, animation, __, child) =>
        FadeTransition(opacity: animation, child: child),
  );
}

CustomTransitionPage<void> _slidePage(GoRouterState state, Widget child) {
  return CustomTransitionPage<void>(
    key: state.pageKey,
    child: child,
    transitionDuration: const Duration(milliseconds: 280),
    transitionsBuilder: (_, animation, __, child) {
      final offset = Tween<Offset>(
        begin: const Offset(0.06, 0),
        end: Offset.zero,
      ).animate(CurvedAnimation(parent: animation, curve: Curves.easeOutCubic));
      return SlideTransition(
        position: offset,
        child: FadeTransition(opacity: animation, child: child),
      );
    },
  );
}
