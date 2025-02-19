import 'package:dio/dio.dart';
import 'package:weather/core/exception/server_exception.dart';

// 역지오코딩 API 호출
class AddressRemoteDataSource {
  final Dio dio;

  AddressRemoteDataSource({required this.dio});

  Future<Map<String, dynamic>> getAddressFromCoordinates(
      {required double latitude, required double longitude}) async {
    try {
      final response = await dio.get("coord2regioncode.json", queryParameters: {
        "x": longitude,
        "y": latitude,
      });

      return response.data;
    } on DioException catch (e) {
      throw ServerException.fromDioError(e);
    }
  }
}
