import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';

class OverviewItem {
  final IconData icon;
  final String label;
  final String description;

  const OverviewItem({required this.icon, required this.label, required this.description});
}

class OverviewStrip extends StatelessWidget {
  final List<OverviewItem> items;

  const OverviewStrip({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < items.length; i++) ...[
          if (i > 0) const SizedBox(width: AppSpacing.sm),
          Expanded(child: _OverviewCard(item: items[i], index: i)),
        ],
      ],
    );
  }
}

class _OverviewCard extends StatelessWidget {
  final OverviewItem item;
  final int index;

  const _OverviewCard({required this.item, required this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.md, horizontal: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: AppColors.divider),
      ),
      child: Column(
        children: [
          Icon(item.icon, color: AppColors.accent, size: 22),
          const SizedBox(height: AppSpacing.sm),
          Text(
            item.label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 12.5,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            item.description,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.textSecondary, fontSize: 11, height: 1.3),
          ),
        ],
      ),
    )
        .animate(delay: Duration(milliseconds: 120 * index))
        .fadeIn(duration: 450.ms, curve: Curves.easeOutBack)
        .slideY(begin: 0.3, end: 0, duration: 450.ms, curve: Curves.easeOutBack)
        .scale(begin: const Offset(0.85, 0.85), end: const Offset(1, 1), duration: 450.ms);
  }
}
