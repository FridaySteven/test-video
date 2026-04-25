import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/video_entity.dart';

part 'video_feed_state.freezed.dart';

@freezed
abstract class VideoFeedState with _$VideoFeedState {
  const factory VideoFeedState({
    @Default([]) List<VideoEntity> videos,
    @Default(0) int currentIndex,
    @Default(1) int page,
    @Default(false) bool isInitialLoading,
    @Default(false) bool isLoadingMore,
    @Default(false) bool hasReachedEnd,
    String? errorMessage,
  }) = _VideoFeedState;
}
