/// SharedPreferences key helpers shared between [ChapterCubit] (which
/// writes them) and any other screen that needs to read a chapter's
/// persisted reading progress/bookmark state (e.g. the chapters list).
library;

String chapterProgressPrefsKey(int chapterNumber) => 'chapter_${chapterNumber}_progress';

String chapterBookmarkPrefsKey(int chapterNumber) => 'chapter_${chapterNumber}_bookmarked';
