import 'package:afridelight/features/catalog/data/dish_repository.dart';
import 'package:afridelight/features/catalog/data/mock_dish_repository.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final dishRepositoryProvider = Provider<DishRepository>(
  (ref) => MockDishRepository(),
);

final dishesProvider = FutureProvider<List<Dish>>(
  (ref) => ref.watch(dishRepositoryProvider).getDishes(),
);

final dishProvider = FutureProvider.family<Dish?, String>(
  (ref, id) => ref.watch(dishRepositoryProvider).getDishById(id),
);

final menuSearchProvider = StateProvider<String>((ref) => '');

final selectedCategoryProvider =
    StateProvider<DishCategory?>((ref) => DishCategory.chicken);

final filteredDishesProvider = Provider<AsyncValue<List<Dish>>>((ref) {
  final dishes = ref.watch(dishesProvider);
  final query = ref.watch(menuSearchProvider).trim().toLowerCase();
  final category = ref.watch(selectedCategoryProvider);

  return dishes.whenData((items) {
    return items.where((dish) {
      final matchesQuery = query.isEmpty ||
          dish.name.toLowerCase().contains(query) ||
          dish.description.toLowerCase().contains(query);

      final matchesCategory =
          category == null || dish.category == category;

      return matchesQuery && matchesCategory;
    }).toList(growable: false);
  });
});
