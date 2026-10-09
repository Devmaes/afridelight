import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/widgets/search_field.dart';
import 'package:flutter/material.dart';

class AppHeader extends StatelessWidget {
  const AppHeader({
    required this.title,
    this.showSearch = true,
    this.onSearchChanged,
    super.key,
  });

  final String title;
  final bool showSearch;
  final ValueChanged<String>? onSearchChanged;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.headerOrange,
      padding: EdgeInsets.fromLTRB(
        24,
        MediaQuery.paddingOf(context).top + 20,
        24,
        showSearch ? 22 : 26,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 39,
                    fontWeight: FontWeight.w800,
                    letterSpacing: -1.5,
                  ),
                ),
              ),
              const Icon(
                Icons.notifications_none_rounded,
                color: Colors.white,
                size: 34,
              ),
            ],
          ),
          if (showSearch) ...[
            const SizedBox(height: 20),
            AppSearchField(
              hintText: 'Rechercher un plat, une cuisine...',
              onChanged: onSearchChanged,
            ),
          ],
        ],
      ),
    );
  }
}
