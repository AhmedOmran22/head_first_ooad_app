import '../entities/chapter.dart';
import '../repositories/chapter_repository.dart';

class GetChapter {
  final ChapterRepository repository;

  const GetChapter(this.repository);

  Future<Chapter> call(int chapterNumber) => repository.getChapter(chapterNumber);
}
