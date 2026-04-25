import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/usecases/get_popular_videos_usecase.dart';
import '../../domain/usecases/search_videos_usecase.dart';
import 'video_feed_event.dart';
import 'video_feed_state.dart';

class VideoFeedBloc extends Bloc<VideoFeedEvent, VideoFeedState> {
  final GetPopularVideosUseCase getPopularVideosUseCase;
  final SearchVideosUseCase searchVideosUseCase;

  static const int _perPage = 20;
  static const int _loadMoreThreshold = 6;

  VideoFeedBloc({
    required this.getPopularVideosUseCase,
    required this.searchVideosUseCase,
  }) : super(const VideoFeedState()) {
    on<VideoFeedStarted>(_onStarted);
    on<VideoFeedLoadMoreRequested>(_onLoadMoreRequested);
    on<VideoFeedPageChanged>(_onPageChanged);
    on<VideoFeedRefreshRequested>(_onRefreshRequested);
  }

  Future<void> _onStarted(
    VideoFeedStarted event,
    Emitter<VideoFeedState> emit,
  ) async {
    emit(state.copyWith(isInitialLoading: true, errorMessage: null));

    final result = await getPopularVideosUseCase(
      GetPopularVideosParams(page: 1, perPage: _perPage),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            errorMessage: failure.message,
          ),
        );
      },
      (videos) {
        emit(
          state.copyWith(
            isInitialLoading: false,
            videos: videos,
            page: 1,
            hasReachedEnd: videos.length < _perPage,
            currentIndex: 0,
          ),
        );
      },
    );
  }

  Future<void> _onLoadMoreRequested(
    VideoFeedLoadMoreRequested event,
    Emitter<VideoFeedState> emit,
  ) async {
    if (state.isLoadingMore || state.hasReachedEnd) return;

    emit(state.copyWith(isLoadingMore: true, errorMessage: null));

    final nextPage = state.page + 1;
    final result = await getPopularVideosUseCase(
      GetPopularVideosParams(page: nextPage, perPage: _perPage),
    );

    result.fold(
      (failure) {
        emit(
          state.copyWith(isLoadingMore: false, errorMessage: failure.message),
        );
      },
      (videos) {
        if (videos.isEmpty) {
          emit(state.copyWith(isLoadingMore: false, hasReachedEnd: true));
        } else {
          emit(
            state.copyWith(
              isLoadingMore: false,
              videos: List.of(state.videos)..addAll(videos),
              page: nextPage,
              hasReachedEnd: videos.length < _perPage,
            ),
          );
        }
      },
    );
  }

  void _onPageChanged(
    VideoFeedPageChanged event,
    Emitter<VideoFeedState> emit,
  ) {
    emit(state.copyWith(currentIndex: event.index));

    if (event.index >= state.videos.length - _loadMoreThreshold) {
      add(const VideoFeedEvent.loadMoreRequested());
    }
  }

  Future<void> _onRefreshRequested(
    VideoFeedRefreshRequested event,
    Emitter<VideoFeedState> emit,
  ) async {
    add(const VideoFeedEvent.started());
  }
}
