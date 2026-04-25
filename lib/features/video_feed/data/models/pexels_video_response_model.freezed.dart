// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'pexels_video_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PexelsVideoResponseModel {

 int get page;@JsonKey(name: 'per_page') int get perPage; List<VideoModel> get videos;@JsonKey(name: 'total_results') int get totalResults;@JsonKey(name: 'next_page') String? get nextPage;
/// Create a copy of PexelsVideoResponseModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PexelsVideoResponseModelCopyWith<PexelsVideoResponseModel> get copyWith => _$PexelsVideoResponseModelCopyWithImpl<PexelsVideoResponseModel>(this as PexelsVideoResponseModel, _$identity);

  /// Serializes this PexelsVideoResponseModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PexelsVideoResponseModel&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&const DeepCollectionEquality().equals(other.videos, videos)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,perPage,const DeepCollectionEquality().hash(videos),totalResults,nextPage);

@override
String toString() {
  return 'PexelsVideoResponseModel(page: $page, perPage: $perPage, videos: $videos, totalResults: $totalResults, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class $PexelsVideoResponseModelCopyWith<$Res>  {
  factory $PexelsVideoResponseModelCopyWith(PexelsVideoResponseModel value, $Res Function(PexelsVideoResponseModel) _then) = _$PexelsVideoResponseModelCopyWithImpl;
@useResult
$Res call({
 int page,@JsonKey(name: 'per_page') int perPage, List<VideoModel> videos,@JsonKey(name: 'total_results') int totalResults,@JsonKey(name: 'next_page') String? nextPage
});




}
/// @nodoc
class _$PexelsVideoResponseModelCopyWithImpl<$Res>
    implements $PexelsVideoResponseModelCopyWith<$Res> {
  _$PexelsVideoResponseModelCopyWithImpl(this._self, this._then);

  final PexelsVideoResponseModel _self;
  final $Res Function(PexelsVideoResponseModel) _then;

/// Create a copy of PexelsVideoResponseModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? page = null,Object? perPage = null,Object? videos = null,Object? totalResults = null,Object? nextPage = freezed,}) {
  return _then(_self.copyWith(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PexelsVideoResponseModel].
extension PexelsVideoResponseModelPatterns on PexelsVideoResponseModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PexelsVideoResponseModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PexelsVideoResponseModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PexelsVideoResponseModel value)  $default,){
final _that = this;
switch (_that) {
case _PexelsVideoResponseModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PexelsVideoResponseModel value)?  $default,){
final _that = this;
switch (_that) {
case _PexelsVideoResponseModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int page, @JsonKey(name: 'per_page')  int perPage,  List<VideoModel> videos, @JsonKey(name: 'total_results')  int totalResults, @JsonKey(name: 'next_page')  String? nextPage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PexelsVideoResponseModel() when $default != null:
return $default(_that.page,_that.perPage,_that.videos,_that.totalResults,_that.nextPage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int page, @JsonKey(name: 'per_page')  int perPage,  List<VideoModel> videos, @JsonKey(name: 'total_results')  int totalResults, @JsonKey(name: 'next_page')  String? nextPage)  $default,) {final _that = this;
switch (_that) {
case _PexelsVideoResponseModel():
return $default(_that.page,_that.perPage,_that.videos,_that.totalResults,_that.nextPage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int page, @JsonKey(name: 'per_page')  int perPage,  List<VideoModel> videos, @JsonKey(name: 'total_results')  int totalResults, @JsonKey(name: 'next_page')  String? nextPage)?  $default,) {final _that = this;
switch (_that) {
case _PexelsVideoResponseModel() when $default != null:
return $default(_that.page,_that.perPage,_that.videos,_that.totalResults,_that.nextPage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PexelsVideoResponseModel implements PexelsVideoResponseModel {
  const _PexelsVideoResponseModel({required this.page, @JsonKey(name: 'per_page') required this.perPage, required final  List<VideoModel> videos, @JsonKey(name: 'total_results') required this.totalResults, @JsonKey(name: 'next_page') this.nextPage}): _videos = videos;
  factory _PexelsVideoResponseModel.fromJson(Map<String, dynamic> json) => _$PexelsVideoResponseModelFromJson(json);

@override final  int page;
@override@JsonKey(name: 'per_page') final  int perPage;
 final  List<VideoModel> _videos;
@override List<VideoModel> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}

@override@JsonKey(name: 'total_results') final  int totalResults;
@override@JsonKey(name: 'next_page') final  String? nextPage;

/// Create a copy of PexelsVideoResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PexelsVideoResponseModelCopyWith<_PexelsVideoResponseModel> get copyWith => __$PexelsVideoResponseModelCopyWithImpl<_PexelsVideoResponseModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PexelsVideoResponseModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PexelsVideoResponseModel&&(identical(other.page, page) || other.page == page)&&(identical(other.perPage, perPage) || other.perPage == perPage)&&const DeepCollectionEquality().equals(other._videos, _videos)&&(identical(other.totalResults, totalResults) || other.totalResults == totalResults)&&(identical(other.nextPage, nextPage) || other.nextPage == nextPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,page,perPage,const DeepCollectionEquality().hash(_videos),totalResults,nextPage);

@override
String toString() {
  return 'PexelsVideoResponseModel(page: $page, perPage: $perPage, videos: $videos, totalResults: $totalResults, nextPage: $nextPage)';
}


}

/// @nodoc
abstract mixin class _$PexelsVideoResponseModelCopyWith<$Res> implements $PexelsVideoResponseModelCopyWith<$Res> {
  factory _$PexelsVideoResponseModelCopyWith(_PexelsVideoResponseModel value, $Res Function(_PexelsVideoResponseModel) _then) = __$PexelsVideoResponseModelCopyWithImpl;
@override @useResult
$Res call({
 int page,@JsonKey(name: 'per_page') int perPage, List<VideoModel> videos,@JsonKey(name: 'total_results') int totalResults,@JsonKey(name: 'next_page') String? nextPage
});




}
/// @nodoc
class __$PexelsVideoResponseModelCopyWithImpl<$Res>
    implements _$PexelsVideoResponseModelCopyWith<$Res> {
  __$PexelsVideoResponseModelCopyWithImpl(this._self, this._then);

  final _PexelsVideoResponseModel _self;
  final $Res Function(_PexelsVideoResponseModel) _then;

/// Create a copy of PexelsVideoResponseModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? page = null,Object? perPage = null,Object? videos = null,Object? totalResults = null,Object? nextPage = freezed,}) {
  return _then(_PexelsVideoResponseModel(
page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,perPage: null == perPage ? _self.perPage : perPage // ignore: cast_nullable_to_non_nullable
as int,videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoModel>,totalResults: null == totalResults ? _self.totalResults : totalResults // ignore: cast_nullable_to_non_nullable
as int,nextPage: freezed == nextPage ? _self.nextPage : nextPage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
