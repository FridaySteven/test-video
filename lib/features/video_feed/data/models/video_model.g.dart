// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoModel _$VideoModelFromJson(Map<String, dynamic> json) => _VideoModel(
  id: (json['id'] as num).toInt(),
  width: (json['width'] as num).toInt(),
  height: (json['height'] as num).toInt(),
  duration: (json['duration'] as num).toInt(),
  image: json['image'] as String,
  user: PexelsUserModel.fromJson(json['user'] as Map<String, dynamic>),
  videoFiles: (json['video_files'] as List<dynamic>)
      .map((e) => VideoFileModel.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$VideoModelToJson(_VideoModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'width': instance.width,
      'height': instance.height,
      'duration': instance.duration,
      'image': instance.image,
      'user': instance.user,
      'video_files': instance.videoFiles,
    };
