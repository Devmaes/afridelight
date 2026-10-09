import 'package:afridelight/core/providers/core_providers.dart';
import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/utils/currency.dart';
import 'package:afridelight/core/widgets/app_header.dart';
import 'package:afridelight/core/widgets/dish_image.dart';
import 'package:afridelight/core/widgets/primary_button.dart';
import 'package:afridelight/features/cart/application/cart_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class CartPage extends ConsumerStatefulWidget {
  const CartPage({super.key});

  @override
  ConsumerState<CartPage> createState() => _CartPageState();
}

class _CartPageState extends ConsumerState<CartPage> {
  final promoController = TextEditingController();

  @override
  void dispose() {
    promoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final cart = ref.watch(cartControllerProvider);
    final controller = ref.read(cartControllerProvider.notifier);

    return CustomScrollView(
      slivers: [
        const SliverToBoxAdapter(child: AppHeader(title: 'AfriDelight')),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 24, 22, 34),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              const Text('Mon Panier', style: TextStyle(fontSize: 34, fontWeight: FontWeight.w900)),
              const SizedBox(height: 18),
              if (cart.items.isEmpty)
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 80),
                  child: Center(child: Text('Votre panier est vide.')),
                )
              else
                for (var i = 0; i < cart.items.length; i++) ...[
                  _CartItemCard(
                    item: cart.items[i],
                    onIncrement: () => controller.incrementAt(i),
                    onDecrement: () => controller.decrementAt(i),
                    onDelete: () => controller.removeAt(i),
                  ),
                  const SizedBox(height: 14),
                ],
              const SizedBox(height: 12),
              const Text('Code Promo', style: TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: promoController,
                      decoration: const InputDecoration(
                        prefixIcon: Icon(Icons.percent_rounded),
                        hintText: 'Entrez votre code promo',
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FilledButton(
                    onPressed: () {
                      final ok = controller.applyPromo(promoController.text);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text(ok ? 'Code promo appliqué.' : 'Code promo invalide.')),
                      );
                    },
                    style: FilledButton.styleFrom(backgroundColor: AppColors.orangeLight, foregroundColor: AppColors.deepOrange),
                    child: const Text('Appliquer'),
                  ),
                ],
              ),
              const SizedBox(height: 22),
              _Summary(cart: cart),
              const SizedBox(height: 22),
              PrimaryButton(
                label: 'Valider la commande',
                onPressed: () async {
                  await ref.read(audioFeedbackProvider).playSuccess();
                  if (context.mounted) context.go('/tracking');
                },
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _CartItemCard extends StatelessWidget {
  const _CartItemCard({
    required this.item,
    required this.onIncrement,
    required this.onDecrement,
    required this.onDelete,
  });

  final dynamic item;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Row(
        children: [
          SizedBox(width: 100, height: 100, child: DishImage(url: item.dish.imageUrl)),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(item.dish.name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 8),
                Text(formatFcfa(item.unitPrice), style: const TextStyle(color: AppColors.deepOrange, fontSize: 20, fontWeight: FontWeight.w900)),
                const SizedBox(height: 10),
                Row(
                  children: [
                    IconButton.filled(onPressed: onDecrement, icon: const Icon(Icons.remove_rounded), style: IconButton.styleFrom(backgroundColor: AppColors.deepOrange)),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Text('${item.quantity}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w800)),
                    ),
                    IconButton.filled(onPressed: onIncrement, icon: const Icon(Icons.add_rounded), style: IconButton.styleFrom(backgroundColor: AppColors.deepOrange)),
                  ],
                ),
              ],
            ),
          ),
          IconButton(onPressed: onDelete, icon: const Icon(Icons.delete_outline_rounded)),
        ],
      ),
    );
  }
}

class _Summary extends StatelessWidget {
  const _Summary({required this.cart});
  final CartState cart;

  @override
  Widget build(BuildContext context) {
    Widget row(String label, String value, {bool strong = false}) => Padding(
      padding: const EdgeInsets.symmetric(vertical: 7),
      child: Row(
        children: [
          Expanded(child: Text(label, style: TextStyle(fontSize: strong ? 22 : 18, fontWeight: strong ? FontWeight.w900 : FontWeight.w500))),
          Text(value, style: TextStyle(fontSize: strong ? 22 : 18, fontWeight: strong ? FontWeight.w900 : FontWeight.w700, color: strong ? AppColors.deepOrange : AppColors.text)),
        ],
      ),
    );

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(22)),
      child: Column(
        children: [
          row('Sous-total', formatFcfa(cart.subtotal)),
          if (cart.discount > 0) row('Réduction', '- ${formatFcfa(cart.discount)}'),
          row('Frais de livraison', formatFcfa(cart.deliveryFee)),
          const Divider(),
          row('Total', formatFcfa(cart.total), strong: true),
        ],
      ),
    );
  }
}
