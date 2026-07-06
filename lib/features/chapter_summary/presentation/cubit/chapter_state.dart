import 'package:equatable/equatable.dart';
import '../../domain/entities/chapter.dart';

enum ChapterStatus { initial, loading, loaded, error }

class ChapterState extends Equatable {
  final ChapterStatus status;
  final Chapter? chapter;
  final String? errorMessage;
  final double readingProgress;
  final bool isBookmarked;

  const ChapterState({
    this.status = ChapterStatus.initial,
    this.chapter,
    this.errorMessage,
    this.readingProgress = 0,
    this.isBookmarked = false,
  });

  ChapterState copyWith({
    ChapterStatus? status,
    Chapter? chapter,
    String? errorMessage,
    double? readingProgress,
    bool? isBookmarked,
  }) {
    return ChapterState(
      status: status ?? this.status,
      chapter: chapter ?? this.chapter,
      errorMessage: errorMessage ?? this.errorMessage,
      readingProgress: readingProgress ?? this.readingProgress,
      isBookmarked: isBookmarked ?? this.isBookmarked,
    );
  }

  @override
  List<Object?> get props =>
      [status, chapter, errorMessage, readingProgress, isBookmarked];
}
