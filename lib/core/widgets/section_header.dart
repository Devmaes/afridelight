import 'package:afridelight/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({
    required this.title,
    this.actionText = 'Voir tout',
    this.onTap,
    super.key,
  });

  final String title;
  final String actionText;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 26,
                ),
          ),
        ),
        TextButton.icon(
          onPressed: onTap,
          iconAlignment: IconAlignment.end,
          label: Text(actionText),
          icon: const Icon(Icons.chevron_right_rounded),
          style: TextButton.styleFrom(
            foregroundColor: AppColors.deepOrange,
            textStyle: const TextStyle(fontSize: 16),
          ),
        ),
      ],
    );
  }
}
