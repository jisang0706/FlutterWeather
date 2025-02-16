import 'package:dio/dio.dart';

import '../config/config.dart';

// api 통신을 위한 Dio 싱글톤 패턴
class DioClient {
  static final DioClient _instance = DioClient._internal();
  late final Dio kakaoDio;
  late final Dio weatherDio;

  factory DioClient() => _instance;

  DioClient._internal() {
    kakaoDio = Dio(BaseOptions(
        baseUrl: Config.kakaoRestApiBaseUrl,
        headers: {"Authorization": "KakaoAK ${Config.kakaoRestApiKey}"},
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 10)))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));

    weatherDio = Dio(BaseOptions(
        baseUrl: Config.weatherBaseUrl,
        connectTimeout: Duration(seconds: 10),
        receiveTimeout: Duration(seconds: 10)))
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true));
  }
}
