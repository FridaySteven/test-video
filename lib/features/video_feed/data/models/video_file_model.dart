import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_file_model.freezed.dart';
part 'video_file_model.g.dart';

@freezed
abstract class VideoFileModel with _$VideoFileModel {
  const factory VideoFileModel({
    required int id,
    required String quality,
    @JsonKey(name: 'file_type') required String fileType,
    int? width,
    int? height,
    required String link,
  }) = _VideoFileModel;

  factory VideoFileModel.fromJson(Map<String, dynamic> json) =>
      _$VideoFileModelFromJson(json);
}
