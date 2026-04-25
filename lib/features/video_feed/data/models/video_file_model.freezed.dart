// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_file_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoFileModel {

 int get id; String get quality;@JsonKey(name: 'file_type') String get fileType; int? get width; int? get height; String get link;
/// Create a copy of VideoFileModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoFileModelCopyWith<VideoFileModel> get copyWith => _$VideoFileModelCopyWithImpl<VideoFileModel>(this as VideoFileModel, _$identity);

  /// Serializes this VideoFileModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quality,fileType,width,height,link);

@override
String toString() {
  return 'VideoFileModel(id: $id, quality: $quality, fileType: $fileType, width: $width, height: $height, link: $link)';
}


}

/// @nodoc
abstract mixin class $VideoFileModelCopyWith<$Res>  {
  factory $VideoFileModelCopyWith(VideoFileModel value, $Res Function(VideoFileModel) _then) = _$VideoFileModelCopyWithImpl;
@useResult
$Res call({
 int id, String quality,@JsonKey(name: 'file_type') String fileType, int? width, int? height, String link
});




}
/// @nodoc
class _$VideoFileModelCopyWithImpl<$Res>
    implements $VideoFileModelCopyWith<$Res> {
  _$VideoFileModelCopyWithImpl(this._self, this._then);

  final VideoFileModel _self;
  final $Res Function(VideoFileModel) _then;

/// Create a copy of VideoFileModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quality = null,Object? fileType = null,Object? width = freezed,Object? height = freezed,Object? link = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoFileModel].
extension VideoFileModelPatterns on VideoFileModel {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoFileModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoFileModel() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoFileModel value)  $default,){
final _that = this;
switch (_that) {
case _VideoFileModel():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoFileModel value)?  $default,){
final _that = this;
switch (_that) {
case _VideoFileModel() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String quality, @JsonKey(name: 'file_type')  String fileType,  int? width,  int? height,  String link)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoFileModel() when $default != null:
return $default(_that.id,_that.quality,_that.fileType,_that.width,_that.height,_that.link);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String quality, @JsonKey(name: 'file_type')  String fileType,  int? width,  int? height,  String link)  $default,) {final _that = this;
switch (_that) {
case _VideoFileModel():
return $default(_that.id,_that.quality,_that.fileType,_that.width,_that.height,_that.link);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String quality, @JsonKey(name: 'file_type')  String fileType,  int? width,  int? height,  String link)?  $default,) {final _that = this;
switch (_that) {
case _VideoFileModel() when $default != null:
return $default(_that.id,_that.quality,_that.fileType,_that.width,_that.height,_that.link);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoFileModel implements VideoFileModel {
  const _VideoFileModel({required this.id, required this.quality, @JsonKey(name: 'file_type') required this.fileType, this.width, this.height, required this.link});
  factory _VideoFileModel.fromJson(Map<String, dynamic> json) => _$VideoFileModelFromJson(json);

@override final  int id;
@override final  String quality;
@override@JsonKey(name: 'file_type') final  String fileType;
@override final  int? width;
@override final  int? height;
@override final  String link;

/// Create a copy of VideoFileModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoFileModelCopyWith<_VideoFileModel> get copyWith => __$VideoFileModelCopyWithImpl<_VideoFileModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoFileModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoFileModel&&(identical(other.id, id) || other.id == id)&&(identical(other.quality, quality) || other.quality == quality)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,quality,fileType,width,height,link);

@override
String toString() {
  return 'VideoFileModel(id: $id, quality: $quality, fileType: $fileType, width: $width, height: $height, link: $link)';
}


}

/// @nodoc
abstract mixin class _$VideoFileModelCopyWith<$Res> implements $VideoFileModelCopyWith<$Res> {
  factory _$VideoFileModelCopyWith(_VideoFileModel value, $Res Function(_VideoFileModel) _then) = __$VideoFileModelCopyWithImpl;
@override @useResult
$Res call({
 int id, String quality,@JsonKey(name: 'file_type') String fileType, int? width, int? height, String link
});




}
/// @nodoc
class __$VideoFileModelCopyWithImpl<$Res>
    implements _$VideoFileModelCopyWith<$Res> {
  __$VideoFileModelCopyWithImpl(this._self, this._then);

  final _VideoFileModel _self;
  final $Res Function(_VideoFileModel) _then;

/// Create a copy of VideoFileModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quality = null,Object? fileType = null,Object? width = freezed,Object? height = freezed,Object? link = null,}) {
  return _then(_VideoFileModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,quality: null == quality ? _self.quality : quality // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int?,link: null == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
