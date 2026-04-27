import 'dart:async';

class Debouncer {
  Debouncer({Duration? delay}) : _defaultDelay = delay;

  final Duration? _defaultDelay;
  Timer? _timer;

  bool get isActive => _timer?.isActive ?? false;

  void run(void Function() action, {Duration? delay}) {
    final effectiveDelay = delay ?? _defaultDelay;
    if (effectiveDelay == null) {
      throw ArgumentError('Debouncer requires a delay.');
    }

    cancel();
    _timer = Timer(effectiveDelay, () {
      _timer = null;
      action();
    });
  }

  void cancel() {
    _timer?.cancel();
    _timer = null;
  }

  void dispose() {
    cancel();
  }
}
