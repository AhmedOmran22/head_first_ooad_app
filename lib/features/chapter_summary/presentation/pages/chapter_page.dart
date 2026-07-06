import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injector.dart';
import '../../../../core/markdown/markdown_models.dart';
import '../../../../core/markdown/markdown_parser.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/chapter_cubit.dart';
import '../cubit/chapter_state.dart';
import '../widgets/bottom_progress_bar.dart';
import '../widgets/chapter_body.dart';
import '../widgets/chapter_error_view.dart';
import '../widgets/chapter_loading_skeleton.dart';

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
            return const ChapterLoadingSkeleton();
          }
          if (state.status == ChapterStatus.error || state.chapter == null) {
            return ChapterErrorView(message: state.errorMessage ?? 'Something went wrong.');
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

          return ChapterBody(
            chapter: chapter,
            readingProgress: state.readingProgress,
            isBookmarked: state.isBookmarked,
            onToggleBookmark: () => context.read<ChapterCubit>().toggleBookmark(),
            tabController: _tabController,
            contentScrollController: _contentScrollController,
            contentSections: contentSections,
            takeaways: takeaways,
            sectionKeys: sectionKeys,
            onSectionTap: (title) => _goToSection(title, sectionKeys),
          );
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
