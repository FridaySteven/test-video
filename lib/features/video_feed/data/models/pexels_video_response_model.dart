import 'package:freezed_annotation/freezed_annotation.dart';
import 'video_model.dart';

part 'pexels_video_response_model.freezed.dart';
part 'pexels_video_response_model.g.dart';

@freezed
abstract class PexelsVideoResponseModel with _$PexelsVideoResponseModel {
  const factory PexelsVideoResponseModel({
    required int page,
    @JsonKey(name: 'per_page') required int perPage,
    required List<VideoModel> videos,
    @JsonKey(name: 'total_results') required int totalResults,
    @JsonKey(name: 'next_page') String? nextPage,
  }) = _PexelsVideoResponseModel;

  factory PexelsVideoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsVideoResponseModelFromJson(json);
}
