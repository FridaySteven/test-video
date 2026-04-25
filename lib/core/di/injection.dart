import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import '../network/dio_client.dart';
import '../../features/video_feed/data/datasources/video_remote_datasource.dart';
import '../../features/video_feed/data/datasources/video_remote_datasource_impl.dart';
import '../../features/video_feed/domain/repositories/video_repository.dart';
import '../../features/video_feed/data/repositories/video_repository_impl.dart';
import '../../features/video_feed/domain/usecases/get_popular_videos_usecase.dart';
import '../../features/video_feed/domain/usecases/search_videos_usecase.dart';
import '../../features/video_feed/presentation/bloc/video_feed_bloc.dart';

final sl = GetIt.instance;

Future<void> configureDependencies() async {
  // Core
  sl.registerLazySingleton<Dio>(() => DioClient.create());

  // Data sources
  sl.registerLazySingleton<VideoRemoteDataSource>(
    () => VideoRemoteDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<VideoRepository>(() => VideoRepositoryImpl(sl()));

  // Use cases
  sl.registerLazySingleton(() => GetPopularVideosUseCase(sl()));

  sl.registerLazySingleton(() => SearchVideosUseCase(sl()));

  // Bloc
  sl.registerFactory(
    () =>
        VideoFeedBloc(getPopularVideosUseCase: sl(), searchVideosUseCase: sl()),
  );
}
