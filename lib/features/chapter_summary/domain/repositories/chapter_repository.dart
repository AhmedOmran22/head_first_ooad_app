import '../entities/chapter.dart';

abstract class ChapterRepository {
  Future<Chapter> getChapter(int chapterNumber);
}
