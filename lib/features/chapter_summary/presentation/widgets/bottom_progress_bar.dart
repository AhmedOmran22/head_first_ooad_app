import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/chapter_model.dart';
import '../../domain/entities/chapter.dart';

/// Persistent bottom bar showing reading progress and a link to the next
/// chapter, hidden when no next chapter is registered yet.
class BottomProgressBar extends StatelessWidget {
  final Chapter chapter;
  final double readingProgress;

  const BottomProgressBar({
    super.key,
    required this.chapter,
    required this.readingProgress,
  });

  @override
  Widget build(BuildContext context) {
    final hasNext = kChapterMetadata.containsKey(chapter.number + 1);
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          children: [
            Text(
              '${(readingProgress * 100).round()}% complete',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
            ),
            const Spacer(),
            if (hasNext)
              TextButton(
                onPressed: () => context.push('/chapters/${chapter.number + 1}'),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Ch. ${chapter.number + 1}',
                      style: const TextStyle(
                        color: AppColors.accent,
                        fontSize: 12.5,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 4),
                    const Icon(LucideIcons.arrowRight, size: 14, color: AppColors.accent),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
