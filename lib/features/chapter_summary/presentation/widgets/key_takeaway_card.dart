import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/markdown/inline_text.dart';
import '../../../../core/theme/app_theme.dart';

class KeyTakeawayCard extends StatelessWidget {
  final String text;
  final int index;
  final bool animate;

  const KeyTakeawayCard({
    super.key,
    required this.text,
    required this.index,
    this.animate = true,
  });

  @override
  Widget build(BuildContext context) {
    final card = Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        border: Border.all(color: AppColors.divider),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.success.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: const Icon(LucideIcons.check, size: 14, color: AppColors.success),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: InlineMarkdownText(
              text,
              style: const TextStyle(color: AppColors.textPrimary, fontSize: 14.5, height: 1.5),
            ),
          ),
        ],
      ),
    );

    if (!animate) return card;

    return card
        .animate(delay: Duration(milliseconds: 100 * index))
        .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.2, end: 0, duration: 300.ms, curve: Curves.easeOutCubic);
  }
}
