import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/result/either.dart';
import '../../domain/entities/video_entity.dart';
import '../../domain/repositories/video_repository.dart';
import '../datasources/video_remote_datasource.dart';
import '../models/video_file_model.dart';
import '../models/video_model.dart';

class VideoRepositoryImpl implements VideoRepository {
  final VideoRemoteDataSource remoteDataSource;

  VideoRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<Failure, List<VideoEntity>>> getPopularVideos({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await remoteDataSource.getPopularVideos(
        page: page,
        perPage: perPage,
      );

      final entities = response.videos
          .map(_toEntity)
          .whereType<VideoEntity>()
          .toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> searchVideos({
    required String query,
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await remoteDataSource.searchVideos(
        query: query,
        page: page,
        perPage: perPage,
      );

      final entities = response.videos
          .map(_toEntity)
          .whereType<VideoEntity>()
          .toList();

      return Right(entities);
    } on ServerException catch (e) {
      return Left(Failure.server(message: e.message));
    } catch (e) {
      return Left(Failure.unknown(message: e.toString()));
    }
  }

  VideoEntity? _toEntity(VideoModel model) {
    final bestFile = _selectFeedFile(model.videoFiles);
    if (bestFile == null) return null;

    return VideoEntity(
      id: model.id,
      title: 'Video by ${model.user.name}',
      thumbnailUrl: model.image,
      videoUrl: bestFile.link,
      authorName: model.user.name,
      duration: model.duration,
      width: bestFile.width ?? model.width,
      height: bestFile.height ?? model.height,
    );
  }

  VideoFileModel? _selectFeedFile(List<VideoFileModel> files) {
    final mp4Files = files.where((file) => file.fileType == 'video/mp4');
    if (mp4Files.isEmpty) return null;

    final ranked = List<VideoFileModel>.of(mp4Files)
      ..sort((a, b) => _feedFileScore(a).compareTo(_feedFileScore(b)));

    return ranked.first;
  }

  int _feedFileScore(VideoFileModel file) {
    final width = file.width ?? 0;
    final height = file.height ?? 0;
    final isPortrait = height > width;
    final targetHeight = isPortrait ? 960 : 720;
    final targetWidth = isPortrait ? 540 : 1280;

    final heightPenalty = height == 0 ? 2000 : (height - targetHeight).abs();
    final widthPenalty = width == 0 ? 1000 : ((width - targetWidth).abs() ~/ 2);
    final orientationPenalty = isPortrait ? 0 : 800;
    final qualityPenalty = file.quality == 'hd' ? 0 : 200;

    return heightPenalty + widthPenalty + orientationPenalty + qualityPenalty;
  }
}
