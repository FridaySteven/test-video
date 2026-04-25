// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pexels_video_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PexelsVideoResponseModel _$PexelsVideoResponseModelFromJson(
  Map<String, dynamic> json,
) => _PexelsVideoResponseModel(
  page: (json['page'] as num).toInt(),
  perPage: (json['per_page'] as num).toInt(),
  videos: (json['videos'] as List<dynamic>)
      .map((e) => VideoModel.fromJson(e as Map<String, dynamic>))
      .toList(),
  totalResults: (json['total_results'] as num).toInt(),
  nextPage: json['next_page'] as String?,
);

Map<String, dynamic> _$PexelsVideoResponseModelToJson(
  _PexelsVideoResponseModel instance,
) => <String, dynamic>{
  'page': instance.page,
  'per_page': instance.perPage,
  'videos': instance.videos,
  'total_results': instance.totalResults,
  'next_page': instance.nextPage,
};
