import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/usecases/get_chapter.dart';
import 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final GetChapter getChapter;

  ChapterCubit(this.getChapter) : super(const ChapterState());

  Future<void> loadChapter(int chapterNumber) async {
    emit(state.copyWith(status: ChapterStatus.loading));
    try {
      final chapter = await getChapter(chapterNumber);
      final prefs = await SharedPreferences.getInstance();
      final progress = prefs.getDouble(_progressKey(chapterNumber)) ?? 0;
      final bookmarked = prefs.getBool(_bookmarkKey(chapterNumber)) ?? false;
      emit(
        state.copyWith(
          status: ChapterStatus.loaded,
          chapter: chapter,
          readingProgress: progress,
          isBookmarked: bookmarked,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ChapterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<void> updateProgress(double progress) async {
    final clamped = progress.clamp(0.0, 1.0);
    if ((clamped - state.readingProgress).abs() < 0.01) return;
    emit(state.copyWith(readingProgress: clamped));

    final chapter = state.chapter;
    if (chapter == null) return;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble(_progressKey(chapter.number), clamped);
  }

  Future<void> toggleBookmark() async {
    final chapter = state.chapter;
    if (chapter == null) return;
    final next = !state.isBookmarked;
    emit(state.copyWith(isBookmarked: next));
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_bookmarkKey(chapter.number), next);
  }

  String _progressKey(int chapterNumber) => 'chapter_${chapterNumber}_progress';
  String _bookmarkKey(int chapterNumber) => 'chapter_${chapterNumber}_bookmarked';
}
