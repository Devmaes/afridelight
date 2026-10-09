import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/features/tracking/application/tracking_providers.dart';
import 'package:afridelight/features/tracking/domain/order_tracking.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class TrackingPage extends ConsumerWidget {
  const TrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tracking = ref.watch(currentTrackingProvider);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.headerOrange,
        foregroundColor: Colors.white,
        title: const Text('Suivi de Commande', style: TextStyle(fontWeight: FontWeight.w900)),
        leading: IconButton(onPressed: () => context.go('/cart'), icon: const Icon(Icons.arrow_back_ios_new_rounded)),
      ),
      body: tracking.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (order) => ListView(
          padding: const EdgeInsets.all(22),
          children: [
            const _RouteMap(),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(24)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Commande ${order.orderNumber}', style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900)),
                  Text(order.summary, style: const TextStyle(fontSize: 18, color: AppColors.textSecondary)),
                  const SizedBox(height: 24),
                  Row(
                    children: [
                      for (var i = 0; i < DeliveryStep.values.length; i++) ...[
                        Expanded(child: _Step(step: DeliveryStep.values[i], active: i <= order.currentStep.index, current: i == order.currentStep.index)),
                        if (i != DeliveryStep.values.length - 1)
                          Expanded(child: Container(height: 3, color: i < order.currentStep.index ? AppColors.deepOrange : AppColors.border)),
                      ],
                    ],
                  ),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(color: const Color(0xFFFFF2E7), borderRadius: BorderRadius.circular(18)),
                    child: Row(
                      children: [
                        const CircleAvatar(backgroundColor: AppColors.deepOrange, foregroundColor: Colors.white, child: Icon(Icons.schedule_rounded)),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Text.rich(
                            TextSpan(
                              text: 'Temps estimé : ',
                              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: AppColors.text),
                              children: [
                                TextSpan(text: '${order.estimatedMinutes} minutes', style: const TextStyle(color: AppColors.deepOrange)),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 18),
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(color: Colors.white, border: Border.all(color: AppColors.border), borderRadius: BorderRadius.circular(24)),
              child: Row(
                children: [
                  const CircleAvatar(radius: 34, backgroundColor: AppColors.orangeLight, child: Icon(Icons.delivery_dining_rounded, color: AppColors.deepOrange, size: 38)),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text(order.driverName, style: const TextStyle(fontSize: 21, fontWeight: FontWeight.w900)),
                      const Text('Votre livreur'),
                      Text('⭐ ${order.driverRating}  (${order.driverDeliveries} livraisons)'),
                    ]),
                  ),
                  IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.call_rounded)),
                  const SizedBox(width: 8),
                  IconButton.filledTonal(onPressed: () {}, icon: const Icon(Icons.chat_bubble_rounded)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RouteMap extends StatelessWidget {
  const _RouteMap();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 310,
      decoration: BoxDecoration(
        color: const Color(0xFFF2F1EE),
        borderRadius: BorderRadius.circular(24),
      ),
      child: CustomPaint(
        painter: _RoutePainter(),
        child: const Stack(
          children: [
            Positioned(left: 44, top: 46, child: _MapLabel(icon: Icons.restaurant_rounded, label: 'AfriDelight')),
            Positioned(right: 42, bottom: 42, child: _MapLabel(icon: Icons.home_rounded, label: 'Votre adresse')),
            Center(child: CircleAvatar(radius: 28, backgroundColor: AppColors.deepOrange, foregroundColor: Colors.white, child: Icon(Icons.delivery_dining_rounded, size: 34))),
          ],
        ),
      ),
    );
  }
}

class _RoutePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final road = Paint()
      ..color = AppColors.deepOrange
      ..strokeWidth = 7
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    final path = Path()
      ..moveTo(90, 105)
      ..lineTo(size.width * .38, 125)
      ..lineTo(size.width * .52, 175)
      ..lineTo(size.width * .72, 190)
      ..lineTo(size.width - 86, size.height - 92);
    canvas.drawPath(path, road);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapLabel extends StatelessWidget {
  const _MapLabel({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return DecoratedBox(
      decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(14), boxShadow: const [BoxShadow(color: Color(0x15000000), blurRadius: 12)]),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(children: [Icon(icon, color: AppColors.deepOrange), const SizedBox(width: 6), Text(label, style: const TextStyle(fontWeight: FontWeight.w800))]),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  const _Step({required this.step, required this.active, required this.current});
  final DeliveryStep step;
  final bool active;
  final bool current;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          width: 36,
          height: 36,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: active ? AppColors.deepOrange : Colors.white,
            border: Border.all(color: active ? AppColors.deepOrange : AppColors.muted, width: 2),
          ),
          child: active ? Icon(current ? Icons.delivery_dining_rounded : Icons.check_rounded, color: Colors.white, size: 20) : null,
        ),
        const SizedBox(height: 7),
        Text(step.label, textAlign: TextAlign.center, maxLines: 2, style: TextStyle(fontSize: 11, fontWeight: current ? FontWeight.w900 : FontWeight.w600, color: current ? AppColors.deepOrange : AppColors.textSecondary)),
        if (step.time.isNotEmpty) Text(step.time, style: const TextStyle(fontSize: 11, color: AppColors.muted)),
      ],
    );
  }
}
