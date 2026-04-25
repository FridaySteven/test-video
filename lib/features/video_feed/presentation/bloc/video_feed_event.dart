import 'package:freezed_annotation/freezed_annotation.dart';

part 'video_feed_event.freezed.dart';

@freezed
sealed class VideoFeedEvent with _$VideoFeedEvent {
  const factory VideoFeedEvent.started() = VideoFeedStarted;

  const factory VideoFeedEvent.loadMoreRequested() = VideoFeedLoadMoreRequested;

  const factory VideoFeedEvent.pageChanged({required int index}) =
      VideoFeedPageChanged;

  const factory VideoFeedEvent.refreshRequested() = VideoFeedRefreshRequested;
}
