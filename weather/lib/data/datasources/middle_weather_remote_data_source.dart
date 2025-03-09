import 'package:dio/dio.dart';
import 'package:weather/core/config/config.dart';
import 'package:weather/core/exception/server_exception.dart';

class MiddleWeatherRemoteDataSource {
  final Dio dio;

  MiddleWeatherRemoteDataSource({required this.dio});

  // 중기예보
  Future<Map<String, dynamic>> getMiddleFcst(
      {required String dateTime, required String regId}) async {
    try {
      final response = await dio.get("getMidTa", queryParameters: {
        "serviceKey": Config.weatherApiKey,
        "numOfRows": 10,
        "pageNo": 1,
        "dataType": "JSON",
        "regId": regId,
        "tmFc": dateTime
      });
      return response.data;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}
