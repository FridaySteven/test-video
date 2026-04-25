// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$VideoModel {

 int get id; int get width; int get height; int get duration; String get image; PexelsUserModel get user;@JsonKey(name: 'video_files') List<VideoFileModel> get videoFiles;
/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoModelCopyWith<VideoModel> get copyWith => _$VideoModelCopyWithImpl<VideoModel>(this as VideoModel, _$identity);

  /// Serializes this VideoModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.image, image) || other.image == image)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other.videoFiles, videoFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,width,height,duration,image,user,const DeepCollectionEquality().hash(videoFiles));

@override
String toString() {
  return 'VideoModel(id: $id, width: $width, height: $height, duration: $duration, image: $image, user: $user, videoFiles: $videoFiles)';
}


}

/// @nodoc
abstract mixin class $VideoModelCopyWith<$Res>  {
  factory $VideoModelCopyWith(VideoModel value, $Res Function(VideoModel) _then) = _$VideoModelCopyWithImpl;
@useResult
$Res call({
 int id, int width, int height, int duration, String image, PexelsUserModel user,@JsonKey(name: 'video_files') List<VideoFileModel> videoFiles
});


$PexelsUserModelCopyWith<$Res> get user;

}
/// @nodoc
class _$VideoModelCopyWithImpl<$Res>
    implements $VideoModelCopyWith<$Res> {
  _$VideoModelCopyWithImpl(this._self, this._then);

  final VideoModel _self;
  final $Res Function(VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? width = null,Object? height = null,Object? duration = null,Object? image = null,Object? user = null,Object? videoFiles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PexelsUserModel,videoFiles: null == videoFiles ? _self.videoFiles : videoFiles // ignore: cast_nullable_to_non_nullable
as List<VideoFileModel>,
  ));
}
/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PexelsUserModelCopyWith<$Res> get user {

  return $PexelsUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}


/// Adds pattern-matching-related methods to [VideoModel].
extension VideoModelPatterns on VideoModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoModel value)  $default,){
final _that = this;
switch (_that) {
case _VideoModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoModel value)?  $default,){
final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  int width,  int height,  int duration,  String image,  PexelsUserModel user, @JsonKey(name: 'video_files')  List<VideoFileModel> videoFiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
return $default(_that.id,_that.width,_that.height,_that.duration,_that.image,_that.user,_that.videoFiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  int width,  int height,  int duration,  String image,  PexelsUserModel user, @JsonKey(name: 'video_files')  List<VideoFileModel> videoFiles)  $default,) {final _that = this;
switch (_that) {
case _VideoModel():
return $default(_that.id,_that.width,_that.height,_that.duration,_that.image,_that.user,_that.videoFiles);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  int width,  int height,  int duration,  String image,  PexelsUserModel user, @JsonKey(name: 'video_files')  List<VideoFileModel> videoFiles)?  $default,) {final _that = this;
switch (_that) {
case _VideoModel() when $default != null:
return $default(_that.id,_that.width,_that.height,_that.duration,_that.image,_that.user,_that.videoFiles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _VideoModel implements VideoModel {
  const _VideoModel({required this.id, required this.width, required this.height, required this.duration, required this.image, required this.user, @JsonKey(name: 'video_files') required final  List<VideoFileModel> videoFiles}): _videoFiles = videoFiles;
  factory _VideoModel.fromJson(Map<String, dynamic> json) => _$VideoModelFromJson(json);

@override final  int id;
@override final  int width;
@override final  int height;
@override final  int duration;
@override final  String image;
@override final  PexelsUserModel user;
 final  List<VideoFileModel> _videoFiles;
@override@JsonKey(name: 'video_files') List<VideoFileModel> get videoFiles {
  if (_videoFiles is EqualUnmodifiableListView) return _videoFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videoFiles);
}


/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoModelCopyWith<_VideoModel> get copyWith => __$VideoModelCopyWithImpl<_VideoModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$VideoModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoModel&&(identical(other.id, id) || other.id == id)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.duration, duration) || other.duration == duration)&&(identical(other.image, image) || other.image == image)&&(identical(other.user, user) || other.user == user)&&const DeepCollectionEquality().equals(other._videoFiles, _videoFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,width,height,duration,image,user,const DeepCollectionEquality().hash(_videoFiles));

@override
String toString() {
  return 'VideoModel(id: $id, width: $width, height: $height, duration: $duration, image: $image, user: $user, videoFiles: $videoFiles)';
}


}

/// @nodoc
abstract mixin class _$VideoModelCopyWith<$Res> implements $VideoModelCopyWith<$Res> {
  factory _$VideoModelCopyWith(_VideoModel value, $Res Function(_VideoModel) _then) = __$VideoModelCopyWithImpl;
@override @useResult
$Res call({
 int id, int width, int height, int duration, String image, PexelsUserModel user,@JsonKey(name: 'video_files') List<VideoFileModel> videoFiles
});


@override $PexelsUserModelCopyWith<$Res> get user;

}
/// @nodoc
class __$VideoModelCopyWithImpl<$Res>
    implements _$VideoModelCopyWith<$Res> {
  __$VideoModelCopyWithImpl(this._self, this._then);

  final _VideoModel _self;
  final $Res Function(_VideoModel) _then;

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? width = null,Object? height = null,Object? duration = null,Object? image = null,Object? user = null,Object? videoFiles = null,}) {
  return _then(_VideoModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as int,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as int,duration: null == duration ? _self.duration : duration // ignore: cast_nullable_to_non_nullable
as int,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as PexelsUserModel,videoFiles: null == videoFiles ? _self._videoFiles : videoFiles // ignore: cast_nullable_to_non_nullable
as List<VideoFileModel>,
  ));
}

/// Create a copy of VideoModel
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PexelsUserModelCopyWith<$Res> get user {

  return $PexelsUserModelCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

// dart format on
