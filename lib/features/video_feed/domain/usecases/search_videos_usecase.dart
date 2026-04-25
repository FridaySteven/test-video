import '../../../../core/error/failure.dart';
import '../../../../core/result/either.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/video_entity.dart';
import '../repositories/video_repository.dart';

class SearchVideosParams {
  final String query;
  final int page;
  final int perPage;

  SearchVideosParams({
    required this.query,
    required this.page,
    required this.perPage,
  });
}

class SearchVideosUseCase
    implements UseCase<List<VideoEntity>, SearchVideosParams> {
  final VideoRepository repository;

  SearchVideosUseCase(this.repository);

  @override
  Future<Either<Failure, List<VideoEntity>>> call(SearchVideosParams params) {
    return repository.searchVideos(
      query: params.query,
      page: params.page,
      perPage: params.perPage,
    );
  }
}
