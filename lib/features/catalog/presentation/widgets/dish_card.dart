import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/utils/currency.dart';
import 'package:afridelight/core/widgets/dish_image.dart';
import 'package:afridelight/features/catalog/domain/dish.dart';
import 'package:flutter/material.dart';

class DishCard extends StatelessWidget {
  const DishCard({
    required this.dish,
    required this.onTap,
    this.compact = false,
    super.key,
  });

  final Dish dish;
  final VoidCallback onTap;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(22),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: compact ? 178 : null,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(22),
            boxShadow: const [BoxShadow(color: Color(0x0A000000), blurRadius: 14, offset: Offset(0, 5))],
          ),
          clipBehavior: Clip.antiAlias,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Hero(
                  tag: 'dish-image-${dish.id}',
                  child: DishImage(url: dish.imageUrl, borderRadius: 0),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 2),
                child: Text(
                  dish.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 19, fontWeight: FontWeight.w800),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 2, 14, 12),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        formatFcfa(dish.price),
                        style: const TextStyle(
                          color: AppColors.deepOrange,
                          fontWeight: FontWeight.w900,
                          fontSize: 19,
                        ),
                      ),
                    ),
                    const CircleAvatar(
                      radius: 19,
                      backgroundColor: AppColors.deepOrange,
                      child: Icon(Icons.add_rounded, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
