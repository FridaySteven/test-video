import '../../../../core/error/failure.dart';
import '../../../../core/result/either.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class GetPopularVideosParams {
  final int page;
  final int perPage;

  GetPopularVideosParams({required this.page, required this.perPage});
}

class GetPopularVideosUseCase
    implements UseCase<List<VideoEntity>, GetPopularVideosParams> {
  final VideoRepository repository;

  GetPopularVideosUseCase(this.repository);

  @override
  Future<Either<Failure, List<VideoEntity>>> call(
    GetPopularVideosParams params,
  ) {
    return repository.getPopularVideos(
      page: params.page,
      perPage: params.perPage,
    );
  }
}
