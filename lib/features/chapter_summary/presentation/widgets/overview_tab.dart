import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/chapter.dart';
import 'quote_widget.dart';
import 'sections_toc.dart';
import 'steps_timeline.dart';

/// Default landing tab: answers "what is this chapter about and what's in
/// it?" via a short summary, the 3-step timeline, a core-insight callout
/// and a table of contents.
class OverviewTab extends StatelessWidget {
  final Chapter chapter;
  final List<String> sectionTitles;
  final ValueChanged<String> onSectionTap;

  const OverviewTab({
    super.key,
    required this.chapter,
    required this.sectionTitles,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          chapter.summary,
          style: const TextStyle(color: AppColors.textSecondary, fontSize: 13.5, height: 1.6),
        ),
        const SizedBox(height: AppSpacing.xl),
        StepsTimeline(steps: chapter.steps),
        const SizedBox(height: AppSpacing.md),
        QuoteWidget(text: chapter.coreInsight, label: 'Core insight'),
        const SizedBox(height: AppSpacing.xl),
        SectionsToc(sectionTitles: sectionTitles, onSectionTap: onSectionTap),
      ],
    );
  }
}
