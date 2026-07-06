import 'package:go_router/go_router.dart';

import '../../features/chapter_summary/presentation/pages/chapter_page.dart';

final appRouter = GoRouter(
  initialLocation: '/chapters/1',
  routes: [
    GoRoute(
      path: '/chapters/:chapterNumber',
      builder: (context, state) {
        final chapterNumber = int.parse(state.pathParameters['chapterNumber']!);
        return ChapterPage(chapterNumber: chapterNumber);
      },
    ),
  ],
);
