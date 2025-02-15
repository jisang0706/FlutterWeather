import 'package:dio/dio.dart';
import '../../core/config/config.dart';

// Weather API 호출
class WeatherRemoteDataSource {
  WeatherRemoteDataSource(this.dio);

  final Dio dio;

  Future<Response> getCurrentWeather(
      {required String baseDate, required String baseTime}) async {
    final response = await dio.get(Config.weatherBaseUrl, queryParameters: {
      "serviceKey": Config.weatherApiKey,
      "numOfRows": 10,
      "pageNo": 1,
      "dataType": "JSON",
      "base_date": baseDate,
      "base_time": baseTime,
      "nx": 61,
      "ny": 128
    });
    return response;
  }
}
