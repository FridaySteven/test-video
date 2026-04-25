import 'package:freezed_annotation/freezed_annotation.dart';
import 'pexels_user_model.dart';
import 'video_file_model.dart';

part 'video_model.freezed.dart';
part 'video_model.g.dart';

@freezed
abstract class VideoModel with _$VideoModel {
  const factory VideoModel({
    required int id,
    required int width,
    required int height,
    required int duration,
    required String image,
    required PexelsUserModel user,
    @JsonKey(name: 'video_files') required List<VideoFileModel> videoFiles,
  }) = _VideoModel;

  factory VideoModel.fromJson(Map<String, dynamic> json) =>
      _$VideoModelFromJson(json);
}
