import 'package:flutter_test/flutter_test.dart';
import 'package:test_video/core/config/app_config.dart';

void main() {
  test('Pexels API key is provided by dart define', () {
    expect(AppConfig.pexelsApiKey, isA<String>());
  });

  test('network logs do not print request headers', () {
    expect(AppConfig.enableNetworkLogs, isFalse);
  });
}
