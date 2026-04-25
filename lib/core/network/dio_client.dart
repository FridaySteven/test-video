import 'package:dio/dio.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import '../config/app_config.dart';
import 'api_constants.dart';

class DioClient {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 20),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          if (AppConfig.pexelsApiKey.isNotEmpty)
            'Authorization': AppConfig.pexelsApiKey,
        },
      ),
    );

    if (AppConfig.enableNetworkLogs) {
      dio.interceptors.add(
        TalkerDioLogger(
          settings: const TalkerDioLoggerSettings(
            printRequestHeaders: false,
            printResponseHeaders: false,
            printResponseMessage: true,
          ),
        ),
      );
    }

    return dio;
  }
}
