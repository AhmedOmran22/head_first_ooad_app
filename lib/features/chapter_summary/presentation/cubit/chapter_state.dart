import 'package:equatable/equatable.dart';
import '../../domain/entities/chapter.dart';

enum ChapterStatus { initial, loading, loaded, error }

class ChapterState extends Equatable {
  final ChapterStatus status;
  final Chapter? chapter;
  final String? errorMessage;

  const ChapterState({
    this.status = ChapterStatus.initial,
    this.chapter,
    this.errorMessage,
  });

  ChapterState copyWith({
    ChapterStatus? status,
    Chapter? chapter,
    String? errorMessage,
  }) {
    return ChapterState(
      status: status ?? this.status,
      chapter: chapter ?? this.chapter,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [status, chapter, errorMessage];
}
