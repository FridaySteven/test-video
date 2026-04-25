import 'package:dio/dio.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/network/api_constants.dart';
import '../models/pexels_video_response_model.dart';
import 'video_remote_datasource.dart';

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  final Dio dio;

  VideoRemoteDataSourceImpl(this.dio);

  @override
  Future<PexelsVideoResponseModel> getPopularVideos({
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.popularVideos,
        queryParameters: {'page': page, 'per_page': perPage},
      );
      return PexelsVideoResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }

  @override
  Future<PexelsVideoResponseModel> searchVideos({
    required String query,
    required int page,
    required int perPage,
  }) async {
    try {
      final response = await dio.get(
        ApiConstants.searchVideos,
        queryParameters: {'query': query, 'page': page, 'per_page': perPage},
      );
      return PexelsVideoResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      throw ServerException(e.message ?? 'Server error');
    } catch (e) {
      throw ServerException(e.toString());
    }
  }
}
