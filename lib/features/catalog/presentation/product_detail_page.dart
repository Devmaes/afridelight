import 'package:afridelight/core/providers/core_providers.dart';
import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/utils/currency.dart';
import 'package:afridelight/core/widgets/dish_image.dart';
import 'package:afridelight/core/widgets/primary_button.dart';
import 'package:afridelight/features/cart/application/cart_controller.dart';
import 'package:afridelight/features/catalog/application/catalog_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class ProductDetailPage extends ConsumerStatefulWidget {
  const ProductDetailPage({required this.dishId, super.key});
  final String dishId;

  @override
  ConsumerState<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends ConsumerState<ProductDetailPage> {
  int quantity = 1;
  String? side;

  @override
  Widget build(BuildContext context) {
    final dishAsync = ref.watch(dishProvider(widget.dishId));

    return dishAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) => Center(child: Text('Erreur : $e')),
      data: (dish) {
        if (dish == null) return const Center(child: Text('Plat introuvable'));
        side ??= dish.sides.isEmpty ? null : dish.sides.last;

        return CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 360,
              pinned: true,
              backgroundColor: AppColors.headerOrange,
              leading: IconButton(
                onPressed: () => context.pop(),
                icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              ),
              flexibleSpace: FlexibleSpaceBar(
                background: Hero(
                  tag: 'dish-image-${dish.id}',
                  child: DishImage(url: dish.imageUrl, borderRadius: 0),
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 26, 24, 34),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(dish.name, style: const TextStyle(fontSize: 34, fontWeight: FontWeight.w900))),
                        Text(formatFcfa(dish.price), style: const TextStyle(color: AppColors.deepOrange, fontSize: 28, fontWeight: FontWeight.w900)),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(children: [
                      const Icon(Icons.star_rounded, color: AppColors.star),
                      const SizedBox(width: 6),
                      Text('${dish.rating}  (${dish.reviewCount} avis)', style: const TextStyle(fontWeight: FontWeight.w700)),
                    ]),
                    const SizedBox(height: 20),
                    Text(dish.description, style: const TextStyle(fontSize: 18, height: 1.5, color: AppColors.textSecondary)),
                    if (dish.sides.isNotEmpty) ...[
                      const SizedBox(height: 26),
                      const Text('Choisissez votre accompagnement', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900)),
                      const SizedBox(height: 12),
                      for (final choice in dish.sides)
                        RadioListTile<String>(
                          value: choice,
                          groupValue: side,
                          activeColor: AppColors.deepOrange,
                          title: Text(choice, style: const TextStyle(fontWeight: FontWeight.w700)),
                          onChanged: (value) => setState(() => side = value),
                        ),
                    ],
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        const Expanded(child: Text('Quantité', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900))),
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.deepOrange),
                          onPressed: () => setState(() => quantity = quantity > 1 ? quantity - 1 : 1),
                          icon: const Icon(Icons.remove_rounded),
                        ),
                        SizedBox(width: 52, child: Center(child: Text('$quantity', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900)))),
                        IconButton.filled(
                          style: IconButton.styleFrom(backgroundColor: AppColors.deepOrange),
                          onPressed: () => setState(() => quantity++),
                          icon: const Icon(Icons.add_rounded),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    PrimaryButton(
                      label: 'Ajouter au panier',
                      icon: Icons.shopping_cart_rounded,
                      onPressed: () async {
                        ref.read(cartControllerProvider.notifier).addDish(dish, quantity: quantity, selectedSide: side);
                        await ref.read(audioFeedbackProvider).playSuccess();
                        if (context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('${dish.name} ajouté au panier')),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
