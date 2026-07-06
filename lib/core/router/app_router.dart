import 'package:go_router/go_router.dart';

import '../../features/chapter_summary/presentation/pages/chapter_page.dart';
import '../../features/chapter_summary/presentation/pages/chapters_list_page.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const ChaptersListPage(),
    ),
    GoRoute(
      path: '/chapters/:chapterNumber',
      builder: (context, state) {
        final chapterNumber = int.parse(state.pathParameters['chapterNumber']!);
        return ChapterPage(chapterNumber: chapterNumber);
      },
    ),
  ],
);
