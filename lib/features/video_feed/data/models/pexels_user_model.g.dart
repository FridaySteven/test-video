// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PexelsUserModel _$PexelsUserModelFromJson(Map<String, dynamic> json) =>
    _PexelsUserModel(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$PexelsUserModelToJson(_PexelsUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'url': instance.url,
    };
