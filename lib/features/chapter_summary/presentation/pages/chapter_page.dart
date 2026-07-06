import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/markdown/markdown_parser.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/chapter_cubit.dart';
import '../cubit/chapter_state.dart';
import '../widgets/bottom_progress_bar.dart';
import '../widgets/chapter_header.dart';
import '../widgets/content_tab.dart';
import '../widgets/key_points_tab.dart';
import '../widgets/overview_tab.dart';

/// Reusable chapter summary screen. Pass a [chapterNumber] and the page
/// resolves the right markdown + metadata through [ChapterCubit], which it
/// pulls from the [getIt] service locator rather than an app-wide provider.
class ChapterPage extends StatelessWidget {
  final int chapterNumber;

  const ChapterPage({super.key, required this.chapterNumber});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ChapterCubit>(),
      child: _ChapterView(chapterNumber: chapterNumber),
    );
  }
}

class _ChapterView extends StatefulWidget {
  final int chapterNumber;

  const _ChapterView({required this.chapterNumber});

  @override
  State<_ChapterView> createState() => _ChapterViewState();
}

class _ChapterViewState extends State<_ChapterView> with SingleTickerProviderStateMixin {
  late final TabController _tabController = TabController(length: 3, vsync: this);
  final ScrollController _contentScrollController = ScrollController();
  List<String>? _cachedSectionTitles;
  Map<String, GlobalKey> _sectionKeys = {};

  Map<String, GlobalKey> _sectionKeysFor(List<MdSection> sections) {
    final titles = sections.map((s) => s.title).toList();
    if (_cachedSectionTitles == null || !_listEquals(_cachedSectionTitles!, titles)) {
      _cachedSectionTitles = titles;
      _sectionKeys = {for (final title in titles) title: GlobalKey()};
    }
    return _sectionKeys;
  }

  bool _listEquals(List<String> a, List<String> b) {
    if (a.length != b.length) return false;
    for (var i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  void initState() {
    super.initState();
    context.read<ChapterCubit>().loadChapter(widget.chapterNumber);
    _contentScrollController.addListener(_onContentScroll);
  }

  void _onContentScroll() {
    final position = _contentScrollController.position;
    if (position.maxScrollExtent <= 0) return;
    final progress = position.pixels / position.maxScrollExtent;
    context.read<ChapterCubit>().updateProgress(progress);
  }

  @override
  void dispose() {
    _tabController.dispose();
    _contentScrollController.removeListener(_onContentScroll);
    _contentScrollController.dispose();
    super.dispose();
  }

  void _goToSection(String title, Map<String, GlobalKey> sectionKeys) {
    _tabController.animateTo(1);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final key = sectionKeys[title];
      final ctx = key?.currentContext;
      if (ctx != null) {
        Scrollable.ensureVisible(ctx, duration: const Duration(milliseconds: 300), curve: Curves.easeOutCubic);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (state.status == ChapterStatus.loading || state.status == ChapterStatus.initial) {
            return const _LoadingSkeleton();
          }
          if (state.status == ChapterStatus.error || state.chapter == null) {
            return Center(
              child: Text(
                state.errorMessage ?? 'Something went wrong.',
                style: const TextStyle(color: AppColors.textSecondary),
              ),
            );
          }

          final chapter = state.chapter!;
          final sections = MarkdownParser.parseSections(chapter.markdownContent);
          final takeawaySection = sections.where((s) => s.title.toLowerCase().contains('key takeaways'));
          final takeaways = takeawaySection.isEmpty
              ? <String>[]
              : takeawaySection.first.blocks.whereType<MdListBlock>().expand((b) => b.items).toList();
          final contentSections =
              sections.where((s) => !s.title.toLowerCase().contains('key takeaways')).toList();
          final sectionKeys = _sectionKeysFor(contentSections);

          return Column(
            children: [
              ChapterHeader(
                chapter: chapter,
                readingProgress: state.readingProgress,
                isBookmarked: state.isBookmarked,
                onToggleBookmark: () => context.read<ChapterCubit>().toggleBookmark(),
              ),
              TabBar(
                controller: _tabController,
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
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  children: [
                    OverviewTab(
                      chapter: chapter,
                      sectionTitles: contentSections.map((s) => s.title).toList(),
                      onSectionTap: (title) => _goToSection(title, sectionKeys),
                    ),
                    ContentTab(
                      sections: contentSections,
                      sectionKeys: sectionKeys,
                      scrollController: _contentScrollController,
                      initialProgress: state.readingProgress,
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
        },
      ),
      bottomNavigationBar: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (state.chapter == null) return const SizedBox.shrink();
          return BottomProgressBar(chapter: state.chapter!, readingProgress: state.readingProgress);
        },
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
  const _LoadingSkeleton();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Shimmer.fromColors(
          baseColor: AppColors.surface,
          highlightColor: AppColors.surfaceElevated,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(height: 140, decoration: _skeletonDecoration),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: List.generate(
                  3,
                  (i) => Expanded(
                    child: Container(
                      margin: EdgeInsets.only(right: i == 2 ? 0 : AppSpacing.sm),
                      height: 90,
                      decoration: _skeletonDecoration,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              for (int i = 0; i < 4; i++)
                Container(
                  margin: const EdgeInsets.only(bottom: AppSpacing.md),
                  height: 80,
                  decoration: _skeletonDecoration,
                ),
            ],
          ),
        ),
      ),
    );
  }

  static final _skeletonDecoration = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(16),
  );
}
