import 'package:afridelight/core/providers/core_providers.dart';
import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/widgets/app_header.dart';
import 'package:afridelight/core/widgets/dish_image.dart';
import 'package:afridelight/core/widgets/loading_card.dart';
import 'package:afridelight/core/widgets/section_header.dart';
import 'package:afridelight/features/catalog/application/catalog_providers.dart';
import 'package:afridelight/features/catalog/presentation/widgets/dish_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dishes = ref.watch(dishesProvider);
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: AppHeader(
            title: 'AfriDelight',
            onSearchChanged: (value) =>
                ref.read(menuSearchProvider.notifier).state = value,
          ),
        ),
        SliverPadding(
          padding: const EdgeInsets.fromLTRB(22, 22, 22, 32),
          sliver: SliverList(
            delegate: SliverChildListDelegate([
              _HeroBanner(onTap: () async {
                await ref.read(audioFeedbackProvider).playTap();
                if (context.mounted) context.go('/menu');
              }),
              const SizedBox(height: 24),
              SectionHeader(title: 'Catégories', onTap: () => context.go('/menu')),
              const SizedBox(height: 10),
              const Row(children: [
                Expanded(child: _Category(icon: Icons.local_fire_department_rounded, label: 'Grillades')),
                SizedBox(width: 10),
                Expanded(child: _Category(icon: Icons.soup_kitchen_rounded, label: 'Sauces')),
                SizedBox(width: 10),
                Expanded(child: _Category(icon: Icons.rice_bowl_rounded, label: 'Accompagnements')),
              ]),
              const SizedBox(height: 26),
              SectionHeader(title: 'Plats Recommandés', onTap: () => context.go('/menu')),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: dishes.when(
                  loading: () => const LoadingCard(),
                  error: (e, _) => Center(child: Text('Erreur : $e')),
                  data: (items) => ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: items.where((e) => e.isRecommended).length,
                    separatorBuilder: (_, __) => const SizedBox(width: 12),
                    itemBuilder: (_, index) {
                      final dish = items.where((e) => e.isRecommended).toList()[index];
                      return DishCard(
                        dish: dish,
                        compact: true,
                        onTap: () => context.go('/dish/${dish.id}'),
                      );
                    },
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  const _HeroBanner({required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 2.05,
      child: Stack(
        fit: StackFit.expand,
        children: [
          const DishImage(
            url: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1?auto=format&fit=crop&w=1600&q=85',
            borderRadius: 22,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: const LinearGradient(
                colors: [Color(0xE816100D), Color(0x8016100D), Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const DecoratedBox(
                  decoration: BoxDecoration(color: Color(0xFFFFC632), borderRadius: BorderRadius.all(Radius.circular(99))),
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 13, vertical: 6),
                    child: Text('SPÉCIAL GRILLADES', style: TextStyle(fontWeight: FontWeight.w900)),
                  ),
                ),
                const Spacer(),
                const Text(
                  'Poulet Braisé\n& Poisson Braisé',
                  style: TextStyle(color: Colors.white, fontSize: 28, height: 1.05, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 12),
                FilledButton.icon(
                  onPressed: onTap,
                  icon: const Icon(Icons.arrow_forward_rounded),
                  label: const Text('Commander maintenant'),
                  style: FilledButton.styleFrom(backgroundColor: AppColors.deepOrange, foregroundColor: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Category extends StatelessWidget {
  const _Category({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 94,
      decoration: BoxDecoration(color: const Color(0xFFFFF4E9), borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppColors.deepOrange, size: 30),
          const SizedBox(height: 8),
          FittedBox(child: Text(label, style: const TextStyle(fontWeight: FontWeight.w800))),
        ],
      ),
    );
  }
}
