import 'package:dio/dio.dart';

import '../../core/network/dio_client.dart';

// 역지오코딩 API 호출
class AddressRemoteDataSource {
  final Dio dio = DioClient().kakaoDio;

  Future<Map<String, dynamic>> getAddressFromCoordinates(
      {required double latitude, required double longitude}) async {
    final response = await dio.get("coord2address.json", queryParameters: {
      "x": longitude,
      "y": latitude,
    });

    return response.data;
  }
}
