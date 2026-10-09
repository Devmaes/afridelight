import 'package:flutter/material.dart';

class DishImage extends StatelessWidget {
  const DishImage({
    required this.url,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String url;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.network(
        url,
        fit: fit,
        width: double.infinity,
        height: double.infinity,
        errorBuilder: (_, __, ___) => const ColoredBox(
          color: Color(0xFFEFECEF),
          child: Center(child: Icon(Icons.restaurant_rounded, size: 48)),
        ),
        loadingBuilder: (context, child, progress) {
          if (progress == null) return child;
          return const ColoredBox(
            color: Color(0xFFF4F1F4),
            child: Center(child: CircularProgressIndicator()),
          );
        },
      ),
    );
  }
}
