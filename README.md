# test_video

A Flutter TikTok-style video feed application powered by the Pexels Videos API.
The app focuses on a full-screen vertical video experience with smooth paging,
media preloading, local video caching, and clean feature-layer separation.

## Project Summary

This project is a short-video feed prototype. The Home tab loads popular videos
from Pexels, maps the API response into app-level video entities, and displays
them in a vertically paged feed. Each item plays with `media_kit`, shows creator
metadata, supports tap-to-play/tap-to-pause, and includes a progress slider.

The app currently includes a TikTok-like shell with four bottom navigation tabs:

- Home: implemented video feed.
- Discover: placeholder screen.
- Inbox: placeholder screen.
- Profile: placeholder screen.

## Main Features

- Full-screen vertical video feed using `PageView`.
- Custom TikTok-style page scroll physics for quick snap paging.
- Popular video loading from the Pexels Videos API.
- BLoC-managed feed state for initial load, pagination, page changes, refresh,
  loading-more state, and errors.
- Automatic pagination when the user gets close to the end of the loaded feed.
- Media playback through `media_kit` and `media_kit_video`.
- Only one video plays at a time.
- Tap active video to pause or resume playback.
- Video progress slider with seek support.
- Prepares nearby videos and caches additional upcoming videos.
- Temporary local video cache with queueing, cancellation, size limits, and age
  eviction.
- App lifecycle handling so video pauses when the app is inactive and resumes
  when appropriate.
- Safe media shutdown on Android back navigation before the app exits.

## Tech Stack

- Flutter
- Dart SDK `^3.10.9`
- Flutter version managed by FVM: `3.38.10`
- `flutter_bloc` and `bloc` for state management
- `get_it` for dependency injection
- `go_router` for app routing
- `dio` for HTTP requests
- `talker`, `talker_flutter`, and `talker_dio_logger` for logging
- `media_kit`, `media_kit_video`, and `media_kit_libs_video` for video playback
- `path_provider` for cache storage
- `freezed`, `freezed_annotation`, `json_serializable`, and `json_annotation`
  for immutable models and JSON mapping

## Architecture

The project follows a feature-first, clean-architecture style layout.

```text
lib/
  main.dart
  app/
    router/
  core/
    cache/
    config/
    di/
    error/
    network/
    result/
    usecase/
    utils/
  features/
    main/
      presentation/
    video_feed/
      data/
      domain/
      presentation/
```

### Data Flow

```text
VideoFeedPage
  -> VideoFeedBloc
  -> GetPopularVideosUseCase / SearchVideosUseCase
  -> VideoRepository
  -> VideoRemoteDataSource
  -> DioClient
  -> Pexels Videos API
```

API response models are converted into `VideoEntity` objects before reaching the
UI. The repository also selects the most suitable MP4 file for a feed item,
favoring portrait videos near feed-friendly resolutions.

## Important Files

- `lib/main.dart`: Initializes Flutter, `media_kit`, dependency injection, and
  the routed Material app.
- `lib/app/router/app_router.dart`: Defines the root route and provides the
  `VideoFeedBloc`.
- `lib/core/config/app_config.dart`: Stores app-level configuration such as the
  Pexels API key and network log toggle.
- `lib/core/network/dio_client.dart`: Creates the configured Dio HTTP client.
- `lib/core/cache/video_cache_service.dart`: Downloads and evicts temporary
  cached video files.
- `lib/core/di/injection.dart`: Registers core services, data sources,
  repositories, use cases, and BLoC factories.
- `lib/features/main/presentation/pages/main_page.dart`: Hosts the bottom
  navigation shell and handles media shutdown on back navigation.
- `lib/features/video_feed/presentation/pages/video_feed_page.dart`: Owns feed
  paging, playback synchronization, preloading, caching, and lifecycle handling.
- `lib/features/video_feed/presentation/widgets/video_player_manager.dart`:
  Manages `media_kit` players and controllers.
- `lib/features/video_feed/presentation/widgets/video_player_item.dart`: Renders
  each full-screen video item, controls, metadata, and progress.
- `test/app_config_test.dart`: Covers basic app configuration expectations.

## API Configuration

The app calls:

- `https://api.pexels.com/videos/popular`
- `https://api.pexels.com/videos/search`

The Authorization header is configured from `AppConfig.pexelsApiKey`.

For local development, place a valid Pexels API key in
`lib/core/config/app_config.dart`. For production or shared repositories, avoid
committing real API keys; prefer Dart defines, environment-specific config, or a
backend proxy.

## Caching Behavior

Video files are cached under the platform temporary directory in a
`video-feed-cache` folder.

Current cache rules:

- Maximum cache size: 1 GB.
- Maximum cache age: 24 hours.
- Maximum concurrent downloads: 2.
- Upcoming videos are queued by priority.
- Downloads outside the active cache window are cancelled.
- Cache eviction is best effort and removes old files first.

## Getting Started

Install dependencies:

```bash
flutter pub get
```

Regenerate Freezed and JSON serialization files when models or unions change:

```bash
dart run build_runner build --delete-conflicting-outputs
-
fvm dart run build_runner build --force-jit --delete-conflicting-outputs
```

Run the app:

```bash
flutter run
```

Run static analysis:

```bash
flutter analyze
```

Run tests:

```bash
flutter test
```

## Platform Notes

The standard Flutter platform folders are present for Android, iOS, web, Linux,
macOS, and Windows. Android already includes the `INTERNET` permission required
for loading remote video data.

## Current Limitations

- Search support exists in the data/domain layers, but there is no search UI yet.
- Discover, Inbox, and Profile are placeholder tabs.
- The Pexels API key is currently configured directly in app config.
- Test coverage is minimal and currently focused on configuration checks.
