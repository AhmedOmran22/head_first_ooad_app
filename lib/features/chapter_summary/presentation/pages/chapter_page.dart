import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/markdown/markdown_parser.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/chapter_cubit.dart';
import '../cubit/chapter_state.dart';
import '../widgets/animated_progress_indicator.dart';
import '../widgets/chapter_header.dart';
import '../widgets/key_takeaway_card.dart';
import '../widgets/overview_strip.dart';
import '../widgets/section_card.dart';

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

class _ChapterViewState extends State<_ChapterView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    context.read<ChapterCubit>().loadChapter(widget.chapterNumber);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final position = _scrollController.position;
    if (position.maxScrollExtent <= 0) return;
    final progress = position.pixels / position.maxScrollExtent;
    context.read<ChapterCubit>().updateProgress(progress);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  static const _overviewItems = [
    OverviewItem(
      icon: LucideIcons.target,
      label: 'Customer Needs',
      description: 'Make software do what the customer wants',
    ),
    OverviewItem(
      icon: LucideIcons.puzzle,
      label: 'OO Principles',
      description: 'Encapsulation, delegation, flexibility',
    ),
    OverviewItem(
      icon: LucideIcons.wrench,
      label: 'Great Design',
      description: 'Maintainable, reusable, flexible code',
    ),
  ];

  IconData _iconForSection(String title) {
    final lower = title.toLowerCase();
    if (lower.contains('story') || lower.contains('guitar shop')) return LucideIcons.bookOpen;
    if (lower.contains('overview')) return LucideIcons.map;
    if (lower.contains('class diagram')) return LucideIcons.gitBranch;
    if (lower.contains('step 1') || lower.contains('make it work')) return LucideIcons.hammer;
    if (lower.contains('step 2') || lower.contains('encapsulation')) return LucideIcons.box;
    if (lower.contains('step 3') || lower.contains('delegation') || lower.contains('reusable')) {
      return LucideIcons.recycle;
    }
    if (lower.contains('3 steps')) return LucideIcons.listOrdered;
    if (lower.contains('great software')) return LucideIcons.sparkles;
    if (lower.contains('summary') || lower.contains('evolution')) return LucideIcons.barChart2;
    if (lower.contains('concept')) return LucideIcons.brain;
    if (lower.contains('mistake')) return LucideIcons.alertTriangle;
    if (lower.contains('dumb question') || lower.contains('faq')) return LucideIcons.helpCircle;
    if (lower.contains('terminology')) return LucideIcons.bookMarked;
    if (lower.contains('chapter summary')) return LucideIcons.flagTriangleRight;
    return LucideIcons.fileText;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: BlocBuilder<ChapterCubit, ChapterState>(
        builder: (context, state) {
          if (state.status == ChapterStatus.loading || state.status == ChapterStatus.initial) {
            return _LoadingSkeleton();
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

          return Stack(
            children: [
              CustomScrollView(
                controller: _scrollController,
                slivers: [
                  SliverAppBar(
                    expandedHeight: 220,
                    pinned: true,
                    backgroundColor: AppColors.background,
                    flexibleSpace: ChapterHeader(chapter: chapter),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    sliver: SliverToBoxAdapter(
                      child: OverviewStrip(items: _overviewItems),
                    ),
                  ),
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
                    sliver: SliverList.separated(
                      itemCount: contentSections.length,
                      separatorBuilder: (context, index) => const SizedBox(height: 0),
                      itemBuilder: (context, index) {
                        final section = contentSections[index];
                        return SectionCard(
                          title: section.title,
                          icon: _iconForSection(section.title),
                          blocks: section.blocks,
                        )
                            .animate(delay: Duration(milliseconds: 40 * index))
                            .fadeIn(duration: 350.ms, curve: Curves.easeOutCubic)
                            .slideY(begin: 0.08, end: 0, duration: 350.ms, curve: Curves.easeOutCubic);
                      },
                    ),
                  ),
                  if (takeaways.isNotEmpty)
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(
                        AppSpacing.lg, AppSpacing.lg, AppSpacing.lg, AppSpacing.xxl,
                      ),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Padding(
                              padding: EdgeInsets.only(bottom: AppSpacing.md),
                              child: Row(
                                children: [
                                  Icon(LucideIcons.star, color: AppColors.accent, size: 20),
                                  SizedBox(width: AppSpacing.sm),
                                  Text(
                                    'Key Takeaways',
                                    style: TextStyle(
                                      color: AppColors.textPrimary,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w800,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            for (var i = 0; i < takeaways.length; i++)
                              KeyTakeawayCard(text: takeaways[i], index: i),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: AnimatedProgressIndicatorBar(progress: state.readingProgress),
              ),
            ],
          )
              .animate()
              .fadeIn(duration: 300.ms, curve: Curves.easeOutCubic)
              .scale(begin: const Offset(0.98, 0.98), end: const Offset(1, 1), duration: 300.ms, curve: Curves.easeOutCubic);
        },
      ),
    );
  }
}

class _LoadingSkeleton extends StatelessWidget {
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
