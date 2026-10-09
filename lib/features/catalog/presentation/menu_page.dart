import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/widgets/app_header.dart';
import 'package:afridelight/core/widgets/loading_card.dart';
import 'package:afridelight/features/catalog/application/catalog_providers.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';
import 'package:afridelight/features/catalog/presentation/widgets/dish_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class MenuPage extends ConsumerWidget {
  const MenuPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(selectedCategoryProvider);
    final dishes = ref.watch(filteredDishesProvider);

    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppHeader(
            title: 'Menu',
            onSearchChanged: (value) =>
                ref.read(menuSearchProvider.notifier).state = value,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 86,
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              scrollDirection: Axis.horizontal,
              children: [
                for (final category in <DishCategory?>[
                  DishCategory.chicken,
                  DishCategory.fish,
                  DishCategory.traditional,
                  null,
                ])
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: ChoiceChip(
                      selected: selected == category,
                      label: Text(category?.label ?? 'Tous'),
                      avatar: Icon(
                        category == DishCategory.chicken
                            ? Icons.set_meal_rounded
                            : category == DishCategory.fish
                                ? Icons.phishing_rounded
                                : category == DishCategory.traditional
                                    ? Icons.soup_kitchen_rounded
                                    : Icons.apps_rounded,
                      ),
                      selectedColor: AppColors.orangeLight,
                      labelStyle: TextStyle(
                        color: selected == category ? AppColors.deepOrange : AppColors.text,
                        fontWeight: FontWeight.w800,
                      ),
                      onSelected: (_) => ref.read(selectedCategoryProvider.notifier).state = category,
                    ),
                  ),
              ],
            ),
          ),
        ),
        dishes.when(
          loading: () => const SliverPadding(
            padding: EdgeInsets.all(20),
            sliver: SliverToBoxAdapter(child: LoadingCard(height: 360)),
          ),
          error: (e, _) => SliverFillRemaining(child: Center(child: Text('Erreur : $e'))),
          data: (items) => SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 4, 20, 28),
            sliver: SliverGrid(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: .72,
              ),
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  final dish = items[index];
                  return DishCard(dish: dish, onTap: () => context.go('/dish/${dish.id}'));
                },
                childCount: items.length,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
