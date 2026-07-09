import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/chapter_model.dart';
import '../../domain/entities/chapter.dart';

/// Persistent bottom bar with a link to the next chapter, hidden when no
/// next chapter is registered yet.
class ChapterNavBar extends StatelessWidget {
  final Chapter chapter;

  const ChapterNavBar({super.key, required this.chapter});

  @override
  Widget build(BuildContext context) {
    final hasNext = kChapterMetadata.containsKey(chapter.number + 1);
    if (!hasNext) return const SizedBox.shrink();

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.divider)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
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
