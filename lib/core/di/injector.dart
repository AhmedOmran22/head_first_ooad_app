import 'package:get_it/get_it.dart';

import '../../features/chapter_summary/data/datasources/chapter_local_datasource.dart';
import '../../features/chapter_summary/data/repositories/chapter_repository_impl.dart';
import '../../features/chapter_summary/domain/repositories/chapter_repository.dart';
import '../../features/chapter_summary/domain/usecases/get_chapter.dart';
import '../../features/chapter_summary/presentation/cubit/chapter_cubit.dart';

final getIt = GetIt.instance;

void setupInjector() {
  getIt
    ..registerLazySingleton<ChapterLocalDataSource>(() => ChapterLocalDataSourceImpl())
    ..registerLazySingleton<ChapterRepository>(() => ChapterRepositoryImpl(getIt()))
    ..registerLazySingleton(() => GetChapter(getIt()))
    ..registerFactory(() => ChapterCubit(getIt()));
}
