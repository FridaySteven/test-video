import 'package:freezed_annotation/freezed_annotation.dart';

part 'pexels_user_model.freezed.dart';
part 'pexels_user_model.g.dart';

@freezed
abstract class PexelsUserModel with _$PexelsUserModel {
  const factory PexelsUserModel({
    required int id,
    required String name,
    required String url,
  }) = _PexelsUserModel;

  factory PexelsUserModel.fromJson(Map<String, dynamic> json) =>
      _$PexelsUserModelFromJson(json);
}
