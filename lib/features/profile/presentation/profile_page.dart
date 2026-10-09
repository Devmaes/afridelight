import 'package:afridelight/core/constants/app_meta.dart';
import 'package:afridelight/core/theme/app_colors.dart';
import 'package:afridelight/core/widgets/app_header.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        const AppHeader(title: 'Profil', showSearch: false),
        Padding(
          padding: const EdgeInsets.all(22),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 48,
                backgroundColor: AppColors.orangeLight,
                child: Icon(Icons.person_rounded, color: AppColors.deepOrange, size: 56),
              ),
              const SizedBox(height: 14),
              const Text('Client AfriDelight', style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900)),
              const SizedBox(height: 6),
              const Text('Yaoundé, Cameroun', style: TextStyle(color: AppColors.textSecondary)),
              const SizedBox(height: 28),
              for (final item in const [
                (Icons.receipt_long_rounded, 'Mes commandes'),
                (Icons.location_on_outlined, 'Adresses de livraison'),
                (Icons.notifications_none_rounded, 'Notifications'),
                (Icons.settings_outlined, 'Préférences'),
              ])
                Card(
                  child: ListTile(
                    leading: Icon(item.$1, color: AppColors.deepOrange),
                    title: Text(item.$2, style: const TextStyle(fontWeight: FontWeight.w700)),
                    trailing: const Icon(Icons.chevron_right_rounded),
                    onTap: () {},
                  ),
                ),
              const SizedBox(height: 30),
              const Text('Developed  by ${AppMeta.developer}', style: TextStyle(color: AppColors.muted)),
            ],
          ),
        ),
      ],
    );
  }
}
