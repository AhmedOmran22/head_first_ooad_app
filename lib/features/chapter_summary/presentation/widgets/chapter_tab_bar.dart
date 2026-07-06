import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// The sticky Overview / Content / Key points tab bar.
class ChapterTabBar extends StatelessWidget {
  final TabController controller;

  const ChapterTabBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TabBar(
      controller: controller,
      labelColor: AppColors.accent,
      unselectedLabelColor: AppColors.textSecondary,
      indicatorColor: AppColors.accent,
      indicatorWeight: 2,
      labelStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w700),
      unselectedLabelStyle: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w500),
      tabs: const [
        Tab(text: 'Overview'),
        Tab(text: 'Content'),
        Tab(text: 'Key points'),
      ],
    );
  }
}
