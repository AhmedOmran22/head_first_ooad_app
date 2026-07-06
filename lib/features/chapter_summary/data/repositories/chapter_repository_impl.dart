import '../../domain/entities/chapter.dart';
import '../../domain/repositories/chapter_repository.dart';
import '../datasources/chapter_local_datasource.dart';
import '../models/chapter_model.dart';

class ChapterRepositoryImpl implements ChapterRepository {
  final ChapterLocalDataSource localDataSource;

  const ChapterRepositoryImpl(this.localDataSource);

  @override
  Future<Chapter> getChapter(int chapterNumber) async {
    final meta = kChapterMetadata[chapterNumber];
    if (meta == null) {
      throw ArgumentError('No metadata registered for chapter $chapterNumber');
    }

    final markdown = await localDataSource.loadMarkdown(chapterNumber);

    return ChapterModel(
      number: chapterNumber,
      title: meta.title,
      subtitle: meta.subtitle,
      markdownContent: markdown,
      accentColor: meta.accentColor,
      iconData: meta.iconData,
    );
  }
}
