import 'package:flutter/services.dart' show rootBundle;

abstract class ChapterLocalDataSource {
  Future<String> loadMarkdown(int chapterNumber);
}

class ChapterLocalDataSourceImpl implements ChapterLocalDataSource {
  @override
  Future<String> loadMarkdown(int chapterNumber) {
    return rootBundle.loadString('assets/summaries/chapter$chapterNumber.md');
  }
}
