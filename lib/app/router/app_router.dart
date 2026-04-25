import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/di/injection.dart';
import '../../features/video_feed/presentation/bloc/video_feed_bloc.dart';
import '../../features/video_feed/presentation/bloc/video_feed_event.dart';
import '../../features/main/presentation/pages/main_page.dart';
import 'route_names.dart';

final appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: RouteNames.main,
      builder: (context, state) {
        return BlocProvider(
          create: (_) =>
              sl<VideoFeedBloc>()..add(const VideoFeedEvent.started()),
          child: const MainPage(),
        );
      },
    ),
  ],
);
