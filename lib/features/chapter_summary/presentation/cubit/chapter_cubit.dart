import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_chapter.dart';
import 'chapter_state.dart';

class ChapterCubit extends Cubit<ChapterState> {
  final GetChapter getChapter;

  ChapterCubit(this.getChapter) : super(const ChapterState());

  Future<void> loadChapter(int chapterNumber) async {
    emit(state.copyWith(status: ChapterStatus.loading));
    try {
      final chapter = await getChapter(chapterNumber);
      emit(
        state.copyWith(
          status: ChapterStatus.loaded,
          chapter: chapter,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: ChapterStatus.error, errorMessage: e.toString()));
    }
  }
}
