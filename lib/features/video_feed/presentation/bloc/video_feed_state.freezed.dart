// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_feed_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoFeedState {

 List<VideoEntity> get videos; int get currentIndex; int get page; bool get isInitialLoading; bool get isLoadingMore; bool get hasReachedEnd; String? get errorMessage;
/// Create a copy of VideoFeedState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoFeedStateCopyWith<VideoFeedState> get copyWith => _$VideoFeedStateCopyWithImpl<VideoFeedState>(this as VideoFeedState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedState&&const DeepCollectionEquality().equals(other.videos, videos)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.page, page) || other.page == page)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(videos),currentIndex,page,isInitialLoading,isLoadingMore,hasReachedEnd,errorMessage);

@override
String toString() {
  return 'VideoFeedState(videos: $videos, currentIndex: $currentIndex, page: $page, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $VideoFeedStateCopyWith<$Res>  {
  factory $VideoFeedStateCopyWith(VideoFeedState value, $Res Function(VideoFeedState) _then) = _$VideoFeedStateCopyWithImpl;
@useResult
$Res call({
 List<VideoEntity> videos, int currentIndex, int page, bool isInitialLoading, bool isLoadingMore, bool hasReachedEnd, String? errorMessage
});




}
/// @nodoc
class _$VideoFeedStateCopyWithImpl<$Res>
    implements $VideoFeedStateCopyWith<$Res> {
  _$VideoFeedStateCopyWithImpl(this._self, this._then);

  final VideoFeedState _self;
  final $Res Function(VideoFeedState) _then;

/// Create a copy of VideoFeedState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? videos = null,Object? currentIndex = null,Object? page = null,Object? isInitialLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
videos: null == videos ? _self.videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoEntity>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [VideoFeedState].
extension VideoFeedStatePatterns on VideoFeedState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _VideoFeedState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _VideoFeedState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _VideoFeedState value)  $default,){
final _that = this;
switch (_that) {
case _VideoFeedState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _VideoFeedState value)?  $default,){
final _that = this;
switch (_that) {
case _VideoFeedState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<VideoEntity> videos,  int currentIndex,  int page,  bool isInitialLoading,  bool isLoadingMore,  bool hasReachedEnd,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _VideoFeedState() when $default != null:
return $default(_that.videos,_that.currentIndex,_that.page,_that.isInitialLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<VideoEntity> videos,  int currentIndex,  int page,  bool isInitialLoading,  bool isLoadingMore,  bool hasReachedEnd,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _VideoFeedState():
return $default(_that.videos,_that.currentIndex,_that.page,_that.isInitialLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.errorMessage);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<VideoEntity> videos,  int currentIndex,  int page,  bool isInitialLoading,  bool isLoadingMore,  bool hasReachedEnd,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _VideoFeedState() when $default != null:
return $default(_that.videos,_that.currentIndex,_that.page,_that.isInitialLoading,_that.isLoadingMore,_that.hasReachedEnd,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc


class _VideoFeedState implements VideoFeedState {
  const _VideoFeedState({final  List<VideoEntity> videos = const [], this.currentIndex = 0, this.page = 1, this.isInitialLoading = false, this.isLoadingMore = false, this.hasReachedEnd = false, this.errorMessage}): _videos = videos;


 final  List<VideoEntity> _videos;
@override@JsonKey() List<VideoEntity> get videos {
  if (_videos is EqualUnmodifiableListView) return _videos;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_videos);
}

@override@JsonKey() final  int currentIndex;
@override@JsonKey() final  int page;
@override@JsonKey() final  bool isInitialLoading;
@override@JsonKey() final  bool isLoadingMore;
@override@JsonKey() final  bool hasReachedEnd;
@override final  String? errorMessage;

/// Create a copy of VideoFeedState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$VideoFeedStateCopyWith<_VideoFeedState> get copyWith => __$VideoFeedStateCopyWithImpl<_VideoFeedState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _VideoFeedState&&const DeepCollectionEquality().equals(other._videos, _videos)&&(identical(other.currentIndex, currentIndex) || other.currentIndex == currentIndex)&&(identical(other.page, page) || other.page == page)&&(identical(other.isInitialLoading, isInitialLoading) || other.isInitialLoading == isInitialLoading)&&(identical(other.isLoadingMore, isLoadingMore) || other.isLoadingMore == isLoadingMore)&&(identical(other.hasReachedEnd, hasReachedEnd) || other.hasReachedEnd == hasReachedEnd)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_videos),currentIndex,page,isInitialLoading,isLoadingMore,hasReachedEnd,errorMessage);

@override
String toString() {
  return 'VideoFeedState(videos: $videos, currentIndex: $currentIndex, page: $page, isInitialLoading: $isInitialLoading, isLoadingMore: $isLoadingMore, hasReachedEnd: $hasReachedEnd, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$VideoFeedStateCopyWith<$Res> implements $VideoFeedStateCopyWith<$Res> {
  factory _$VideoFeedStateCopyWith(_VideoFeedState value, $Res Function(_VideoFeedState) _then) = __$VideoFeedStateCopyWithImpl;
@override @useResult
$Res call({
 List<VideoEntity> videos, int currentIndex, int page, bool isInitialLoading, bool isLoadingMore, bool hasReachedEnd, String? errorMessage
});




}
/// @nodoc
class __$VideoFeedStateCopyWithImpl<$Res>
    implements _$VideoFeedStateCopyWith<$Res> {
  __$VideoFeedStateCopyWithImpl(this._self, this._then);

  final _VideoFeedState _self;
  final $Res Function(_VideoFeedState) _then;

/// Create a copy of VideoFeedState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? videos = null,Object? currentIndex = null,Object? page = null,Object? isInitialLoading = null,Object? isLoadingMore = null,Object? hasReachedEnd = null,Object? errorMessage = freezed,}) {
  return _then(_VideoFeedState(
videos: null == videos ? _self._videos : videos // ignore: cast_nullable_to_non_nullable
as List<VideoEntity>,currentIndex: null == currentIndex ? _self.currentIndex : currentIndex // ignore: cast_nullable_to_non_nullable
as int,page: null == page ? _self.page : page // ignore: cast_nullable_to_non_nullable
as int,isInitialLoading: null == isInitialLoading ? _self.isInitialLoading : isInitialLoading // ignore: cast_nullable_to_non_nullable
as bool,isLoadingMore: null == isLoadingMore ? _self.isLoadingMore : isLoadingMore // ignore: cast_nullable_to_non_nullable
as bool,hasReachedEnd: null == hasReachedEnd ? _self.hasReachedEnd : hasReachedEnd // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
