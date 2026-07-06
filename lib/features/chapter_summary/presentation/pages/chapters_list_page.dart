import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/theme/app_theme.dart';
import '../../data/models/chapter_model.dart';
import '../widgets/chapter_list_card.dart';

/// Home screen: a list of every registered chapter, each an animated,
/// tappable card that Hero-animates into the chapter's own header.
class ChaptersListPage extends StatelessWidget {
  const ChaptersListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final entries = kChapterMetadata.entries.toList()..sort((a, b) => a.key.compareTo(b.key));

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            const Text(
              'Head First OOA&D',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 24,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              '${entries.length} of $kTotalChapterCount chapters available',
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.lg),
            for (var i = 0; i < entries.length; i++)
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: ChapterListCard(number: entries[i].key, meta: entries[i].value)
                    .animate(delay: Duration(milliseconds: 80 * i))
                    .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
                    .slideY(begin: 0.08, end: 0, duration: 300.ms, curve: Curves.easeOutCubic),
              ),
          ],
        ),
      ),
    );
  }
}
