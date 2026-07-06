import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/chapter_model.dart';
import '../../domain/entities/chapter.dart';
import 'animated_progress_indicator.dart';

/// Compact, informational chapter header (no big hero/parallax). Shows a
/// back arrow, chapter counter, bookmark action, the chapter pill, title,
/// subtitle and the reading-progress bar.
class ChapterHeader extends StatelessWidget {
  final Chapter chapter;
  final double readingProgress;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;

  const ChapterHeader({
    super.key,
    required this.chapter,
    required this.readingProgress,
    required this.isBookmarked,
    required this.onToggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(AppSpacing.md, AppSpacing.sm, AppSpacing.md, 0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                IconButton(
                  onPressed: context.canPop() ? () => context.pop() : null,
                  icon: const Icon(LucideIcons.arrowLeft, color: AppColors.textPrimary),
                  visualDensity: VisualDensity.compact,
                ),
                Text(
                  'Ch. ${chapter.number} of $kTotalChapterCount',
                  style: const TextStyle(color: AppColors.textSecondary, fontSize: 12.5),
                ),
                const Spacer(),
                IconButton(
                  onPressed: onToggleBookmark,
                  icon: Icon(
                    isBookmarked ? LucideIcons.bookMarked : LucideIcons.bookmark,
                    color: isBookmarked ? AppColors.accent : AppColors.textSecondary,
                  ),
                  visualDensity: VisualDensity.compact,
                ),
              ],
            ),
            Hero(
              tag: 'chapter-badge-${chapter.number}',
              child: Material(
                color: Colors.transparent,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.amber50,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    'Chapter ${chapter.number}',
                    style: const TextStyle(
                      color: AppColors.amber600,
                      fontWeight: FontWeight.w800,
                      fontSize: 12,
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Hero(
              tag: 'chapter-title-${chapter.number}',
              child: Material(
                color: Colors.transparent,
                child: Text(
                  chapter.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.textPrimary,
                    fontSize: 22,
                    fontWeight: FontWeight.w800,
                    height: 1.15,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 2),
            Text(
              chapter.subtitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13, height: 1.3),
            ),
            const SizedBox(height: AppSpacing.sm),
            AnimatedProgressIndicatorBar(progress: readingProgress),
          ],
        ),
      ),
    );
  }
}
