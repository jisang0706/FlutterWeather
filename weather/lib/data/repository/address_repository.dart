import 'package:weather/data/datasources/address_remote_data_source.dart';
import 'package:weather/domain/entities/address_entity.dart';

// 역지오코딩 응답 엔티티로 반환
class AddressRepository {
  Future<AddressEntity> getAddress(
      {required double latitude, required double longitude}) async {
    final data = await AddressRemoteDataSource()
        .getAddressFromCoordinates(latitude: latitude, longitude: longitude);
    return AddressEntity.fromJson(data);
  }
}
