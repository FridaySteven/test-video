import '../models/pexels_video_response_model.dart';

abstract class VideoRemoteDataSource {
  Future<PexelsVideoResponseModel> getPopularVideos({
    required int page,
    required int perPage,
  });

  Future<PexelsVideoResponseModel> searchVideos({
    required String query,
    required int page,
    required int perPage,
  });
}
