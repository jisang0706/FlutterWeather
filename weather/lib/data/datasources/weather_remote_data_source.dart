import 'package:dio/dio.dart';
import 'package:weather/core/config/config.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/region_entity.dart';

// Weather API 호출
class WeatherRemoteDataSource {
  final Dio dio;

  WeatherRemoteDataSource({required this.dio});

  // 현재 날씨
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

  // 단기예보
  Future<Map<String, dynamic>> getVilageFcst(
      {required DateTime dateTime,
      required RegionEntity regionEntity,
      required int pageNo}) async {
    try {
      final response = await dio.get("getVilageFcst", queryParameters: {
        "serviceKey": Config.weatherApiKey,
        "numOfRows": 290,
        "pageNo": pageNo,
        "dataType": "JSON",
        "base_date": DateTimeHelper.dateFormat(dateTime),
        "base_time": "2300",
        "nx": regionEntity.nx,
        "ny": regionEntity.ny
      });
      return response.data;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}
