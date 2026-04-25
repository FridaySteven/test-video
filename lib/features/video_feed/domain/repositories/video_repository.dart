import '../../../../core/error/failure.dart';
import '../../../../core/result/either.dart';
import '../entities/video_entity.dart';

abstract class VideoRepository {
  Future<Either<Failure, List<VideoEntity>>> getPopularVideos({
    required int page,
    required int perPage,
  });

  Future<Either<Failure, List<VideoEntity>>> searchVideos({
    required String query,
    required int page,
    required int perPage,
  });
}
