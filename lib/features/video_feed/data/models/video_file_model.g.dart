// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'video_file_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_VideoFileModel _$VideoFileModelFromJson(Map<String, dynamic> json) =>
    _VideoFileModel(
      id: (json['id'] as num).toInt(),
      quality: json['quality'] as String,
      fileType: json['file_type'] as String,
      width: (json['width'] as num?)?.toInt(),
      height: (json['height'] as num?)?.toInt(),
      link: json['link'] as String,
    );

Map<String, dynamic> _$VideoFileModelToJson(_VideoFileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quality': instance.quality,
      'file_type': instance.fileType,
      'width': instance.width,
      'height': instance.height,
      'link': instance.link,
    };
