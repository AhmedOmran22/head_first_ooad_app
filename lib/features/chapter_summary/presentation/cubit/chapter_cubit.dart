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
      final progress = await _readSavedProgress(chapterNumber);
      emit(state.copyWith(
        status: ChapterStatus.loaded,
        chapter: chapter,
        readingProgress: progress,
      ));
    } catch (e) {
      emit(state.copyWith(status: ChapterStatus.error, errorMessage: e.toString()));
    }
  }

  Future<double> _readSavedProgress(int chapterNumber) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getDouble(_progressKey(chapterNumber)) ?? 0;
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

  String _progressKey(int chapterNumber) => 'chapter_${chapterNumber}_progress';
}
