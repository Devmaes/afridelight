import 'package:flutter/material.dart';

class DishImage extends StatelessWidget {
  const DishImage({
    required this.asset,
    this.borderRadius = 16,
    this.fit = BoxFit.cover,
    super.key,
  });

  final String asset;
  final double borderRadius;
  final BoxFit fit;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: Image.asset(
        asset,
        fit: fit,
        errorBuilder: (context, error, stackTrace) {
          return const ColoredBox(
            color: Color(0xFFEFECEF),
            child: Center(
              child: Icon(Icons.restaurant_rounded, size: 48),
            ),
          );
        },
      ),
    );
  }
}
