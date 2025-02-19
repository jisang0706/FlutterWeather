import 'package:dio/dio.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/core/network/dio_client.dart';
import 'package:weather/domain/entities/region_entity.dart';
import '../../core/config/config.dart';

// Weather API 호출
class WeatherRemoteDataSource {
  WeatherRemoteDataSource();

  final Dio dio = DioClient().weatherDio;

  Future<Map<String, dynamic>> getCurrentWeather(
      {required String baseDate,
      required String baseTime,
      required RegionEntity regionEntity}) async {
    try {
      final response = await dio.get("getUltraSrtNcst", queryParameters: {
        "serviceKey": Config.weatherApiKey,
        "numOfRows": 10,
        "pageNo": 1,
        "dataType": "JSON",
        "base_date": baseDate,
        "base_time": baseTime,
        "nx": regionEntity.nx,
        "ny": regionEntity.ny
      });
      return response.data;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}
