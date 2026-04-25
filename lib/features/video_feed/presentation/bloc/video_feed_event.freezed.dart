// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'video_feed_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$VideoFeedEvent {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedEvent);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoFeedEvent()';
}


}

/// @nodoc
class $VideoFeedEventCopyWith<$Res>  {
$VideoFeedEventCopyWith(VideoFeedEvent _, $Res Function(VideoFeedEvent) __);
}


/// Adds pattern-matching-related methods to [VideoFeedEvent].
extension VideoFeedEventPatterns on VideoFeedEvent {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( VideoFeedStarted value)?  started,TResult Function( VideoFeedLoadMoreRequested value)?  loadMoreRequested,TResult Function( VideoFeedPageChanged value)?  pageChanged,TResult Function( VideoFeedRefreshRequested value)?  refreshRequested,required TResult orElse(),}){
final _that = this;
switch (_that) {
case VideoFeedStarted() when started != null:
return started(_that);case VideoFeedLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case VideoFeedPageChanged() when pageChanged != null:
return pageChanged(_that);case VideoFeedRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( VideoFeedStarted value)  started,required TResult Function( VideoFeedLoadMoreRequested value)  loadMoreRequested,required TResult Function( VideoFeedPageChanged value)  pageChanged,required TResult Function( VideoFeedRefreshRequested value)  refreshRequested,}){
final _that = this;
switch (_that) {
case VideoFeedStarted():
return started(_that);case VideoFeedLoadMoreRequested():
return loadMoreRequested(_that);case VideoFeedPageChanged():
return pageChanged(_that);case VideoFeedRefreshRequested():
return refreshRequested(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( VideoFeedStarted value)?  started,TResult? Function( VideoFeedLoadMoreRequested value)?  loadMoreRequested,TResult? Function( VideoFeedPageChanged value)?  pageChanged,TResult? Function( VideoFeedRefreshRequested value)?  refreshRequested,}){
final _that = this;
switch (_that) {
case VideoFeedStarted() when started != null:
return started(_that);case VideoFeedLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested(_that);case VideoFeedPageChanged() when pageChanged != null:
return pageChanged(_that);case VideoFeedRefreshRequested() when refreshRequested != null:
return refreshRequested(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  started,TResult Function()?  loadMoreRequested,TResult Function( int index)?  pageChanged,TResult Function()?  refreshRequested,required TResult orElse(),}) {final _that = this;
switch (_that) {
case VideoFeedStarted() when started != null:
return started();case VideoFeedLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case VideoFeedPageChanged() when pageChanged != null:
return pageChanged(_that.index);case VideoFeedRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  started,required TResult Function()  loadMoreRequested,required TResult Function( int index)  pageChanged,required TResult Function()  refreshRequested,}) {final _that = this;
switch (_that) {
case VideoFeedStarted():
return started();case VideoFeedLoadMoreRequested():
return loadMoreRequested();case VideoFeedPageChanged():
return pageChanged(_that.index);case VideoFeedRefreshRequested():
return refreshRequested();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  started,TResult? Function()?  loadMoreRequested,TResult? Function( int index)?  pageChanged,TResult? Function()?  refreshRequested,}) {final _that = this;
switch (_that) {
case VideoFeedStarted() when started != null:
return started();case VideoFeedLoadMoreRequested() when loadMoreRequested != null:
return loadMoreRequested();case VideoFeedPageChanged() when pageChanged != null:
return pageChanged(_that.index);case VideoFeedRefreshRequested() when refreshRequested != null:
return refreshRequested();case _:
  return null;

}
}

}

/// @nodoc


class VideoFeedStarted implements VideoFeedEvent {
  const VideoFeedStarted();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedStarted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoFeedEvent.started()';
}


}




/// @nodoc


class VideoFeedLoadMoreRequested implements VideoFeedEvent {
  const VideoFeedLoadMoreRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedLoadMoreRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoFeedEvent.loadMoreRequested()';
}


}




/// @nodoc


class VideoFeedPageChanged implements VideoFeedEvent {
  const VideoFeedPageChanged({required this.index});


 final  int index;

/// Create a copy of VideoFeedEvent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$VideoFeedPageChangedCopyWith<VideoFeedPageChanged> get copyWith => _$VideoFeedPageChangedCopyWithImpl<VideoFeedPageChanged>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedPageChanged&&(identical(other.index, index) || other.index == index));
}


@override
int get hashCode => Object.hash(runtimeType,index);

@override
String toString() {
  return 'VideoFeedEvent.pageChanged(index: $index)';
}


}

/// @nodoc
abstract mixin class $VideoFeedPageChangedCopyWith<$Res> implements $VideoFeedEventCopyWith<$Res> {
  factory $VideoFeedPageChangedCopyWith(VideoFeedPageChanged value, $Res Function(VideoFeedPageChanged) _then) = _$VideoFeedPageChangedCopyWithImpl;
@useResult
$Res call({
 int index
});




}
/// @nodoc
class _$VideoFeedPageChangedCopyWithImpl<$Res>
    implements $VideoFeedPageChangedCopyWith<$Res> {
  _$VideoFeedPageChangedCopyWithImpl(this._self, this._then);

  final VideoFeedPageChanged _self;
  final $Res Function(VideoFeedPageChanged) _then;

/// Create a copy of VideoFeedEvent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? index = null,}) {
  return _then(VideoFeedPageChanged(
index: null == index ? _self.index : index // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

/// @nodoc


class VideoFeedRefreshRequested implements VideoFeedEvent {
  const VideoFeedRefreshRequested();







@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is VideoFeedRefreshRequested);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'VideoFeedEvent.refreshRequested()';
}


}




// dart format on
