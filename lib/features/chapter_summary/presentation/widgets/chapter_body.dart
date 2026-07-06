import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../domain/entities/chapter.dart';
import 'chapter_header.dart';
import 'chapter_tab_bar.dart';
import 'content_tab.dart';
import 'key_points_tab.dart';
import 'overview_tab.dart';

/// Composes the loaded chapter view: compact header, sticky tab bar, the
/// three tab views, and a read-only reading-progress indicator pinned to
/// the right edge of the screen.
class ChapterBody extends StatelessWidget {
  final Chapter chapter;
  final double readingProgress;
  final bool isBookmarked;
  final VoidCallback onToggleBookmark;
  final TabController tabController;
  final ScrollController contentScrollController;
  final List<MdSection> contentSections;
  final List<String> takeaways;
  final Map<String, GlobalKey> sectionKeys;
  final ValueChanged<String> onSectionTap;

  const ChapterBody({
    super.key,
    required this.chapter,
    required this.readingProgress,
    required this.isBookmarked,
    required this.onToggleBookmark,
    required this.tabController,
    required this.contentScrollController,
    required this.contentSections,
    required this.takeaways,
    required this.sectionKeys,
    required this.onSectionTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
          children: [
            ChapterHeader(
              chapter: chapter,
              isBookmarked: isBookmarked,
              onToggleBookmark: onToggleBookmark,
            ),
            ChapterTabBar(controller: tabController),
            Expanded(
              child: TabBarView(
                controller: tabController,
                children: [
                  OverviewTab(
                    chapter: chapter,
                    sectionTitles: contentSections.map((s) => s.title).toList(),
                    onSectionTap: onSectionTap,
                  ),
                  ContentTab(
                    sections: contentSections,
                    sectionKeys: sectionKeys,
                    scrollController: contentScrollController,
                    initialProgress: readingProgress,
                  ),
                  KeyPointsTab(takeaways: takeaways),
                ],
              ),
            ),
          ],
        )
        .animate()
        .fadeIn(duration: 250.ms, curve: Curves.easeOutCubic)
        .slideY(begin: 0.03, end: 0, duration: 250.ms, curve: Curves.easeOutCubic);
  }
}
