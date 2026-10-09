import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavoritesController extends StateNotifier<Set<String>> {
  FavoritesController()
      : super(<String>{'poulet-dg', 'ndole', 'mafe'});

  void toggle(String dishId) {
    final updated = {...state};
    if (updated.contains(dishId)) {
      updated.remove(dishId);
    } else {
      updated.add(dishId);
    }
    state = updated;
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesController, Set<String>>(
  (ref) => FavoritesController(),
);
