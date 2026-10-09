import 'package:afridelight/core/providers/core_providers.dart';
import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/widgets/app_header.dart';
import 'package:afridelight/core/widgets/dish_image.dart';
import 'package:afridelight/core/widgets/primary_button.dart';
import 'package:afridelight/features/cart/application/cart_controller.dart';
import 'package:afridelight/features/catalog/application/catalog_providers.dart';
import 'package:afridelight/features/favorites/application/favorites_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ids = ref.watch(favoritesProvider);
    final dishes = ref.watch(dishesProvider);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: AppHeader(title: 'Mes Favoris', showSearch: false)),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              dishes.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Erreur : $e'),
                data: (items) {
                  final favorites = items.where((d) => ids.contains(d.id)).toList();
                  if (favorites.isEmpty) return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 80),
                    child: Center(child: Text('Aucun favori pour le moment.')),
                  );
                  return Column(
                    children: [
                      for (final dish in favorites) ...[
                        Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(22),
                          child: InkWell(
                            onTap: () => context.go('/dish/${dish.id}'),
                            borderRadius: BorderRadius.circular(22),
                            child: Padding(
                              padding: const EdgeInsets.all(14),
                              child: Row(
                                children: [
                                  SizedBox(width: 118, height: 112, child: DishImage(url: dish.imageUrl)),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(dish.name, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                                        const SizedBox(height: 6),
                                        Text(dish.description, maxLines: 2, overflow: TextOverflow.ellipsis),
                                        const SizedBox(height: 10),
                                        const Text('Ajouté récemment', style: TextStyle(color: AppColors.muted)),
                                      ],
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () => ref.read(favoritesProvider.notifier).toggle(dish.id),
                                    icon: const Icon(Icons.favorite_rounded, color: AppColors.deepOrange, size: 30),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 14),
                      ],
                      const SizedBox(height: 12),
                      PrimaryButton(
                        label: 'Commander la sélection',
                        icon: Icons.arrow_forward_rounded,
                        onPressed: () async {
                          for (final dish in favorites) {
                            ref.read(cartControllerProvider.notifier).addDish(dish);
                          }
                          await ref.read(audioFeedbackProvider).playSuccess();
                          if (context.mounted) context.go('/cart');
                        },
                      ),
                    ],
                  );
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
