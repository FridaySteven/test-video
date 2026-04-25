import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_entity.freezed.dart';

@freezed
abstract class VideoEntity with _$VideoEntity {
  const factory VideoEntity({
    required int id,
    required String title,
    required String thumbnailUrl,
    required String videoUrl,
    required String authorName,
    required int duration,
    required int width,
    required int height,
  }) = _VideoEntity;
}
