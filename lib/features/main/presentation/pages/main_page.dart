import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../../features/video_feed/presentation/pages/video_feed_page.dart';
import 'discover_page.dart';
import 'inbox_page.dart';
import 'profile_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> implements PopEntry<Object?> {
  int _currentIndex = 0;
  bool _isClosing = false;
  // Keep Android back routed through Flutter until media teardown is complete.
  final ValueNotifier<bool> _canPopAfterMediaShutdown = ValueNotifier(false);
  ModalRoute<dynamic>? _route;
  late final VideoFeedPageController _videoFeedController;

  @override
  ValueListenable<bool> get canPopNotifier => _canPopAfterMediaShutdown;

  @override
  void initState() {
    super.initState();
    _videoFeedController = VideoFeedPageController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route == _route) return;

    _route?.unregisterPopEntry(this);
    _route = route;
    _route?.registerPopEntry(this);
  }

  @override
  void dispose() {
    _route?.unregisterPopEntry(this);
    _canPopAfterMediaShutdown.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      VideoFeedPage(
        isActive: _currentIndex == 0,
        controller: _videoFeedController,
      ),
      const DiscoverPage(),
      const InboxPage(),
      const ProfilePage(),
    ];

    return BackButtonListener(
      onBackButtonPressed: _handleBackButtonPressed,
      child: Scaffold(
        backgroundColor: Colors.black,
        body: IndexedStack(index: _currentIndex, children: pages),
        bottomNavigationBar: BottomNavigationBar(
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white.withValues(alpha: 0.5),
          currentIndex: _currentIndex,
          onTap: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(
              icon: Icon(Icons.search),
              label: 'Discover',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.message), label: 'Inbox'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
          ],
        ),
      ),
    );
  }

  Future<bool> _handleBackButtonPressed() async {
    if (_isClosing) return true;

    _isClosing = true;
    try {
      await _videoFeedController.shutdown();
    } catch (_) {
      // Do not keep the app open if media cleanup reports a plugin error.
    } finally {
      _isClosing = false;
    }

    _canPopAfterMediaShutdown.value = true;

    return false;
  }

  @override
  void onPopInvokedWithResult(bool didPop, Object? result) {}

  @override
  void onPopInvoked(bool didPop) {}
}
