import 'package:weather/domain/entities/address_entity.dart';

import '../../data/repository/address_repository.dart';

// 현 위치 검색을 위한 역지오코딩
class GetAddressUsecase {
  late final AddressRepository repository;

  GetAddressUsecase() {
    repository = AddressRepository();
  }

  Future<AddressEntity> execute(
      {required double latitude, required double longitude}) async {
    return await repository.getAddress(
        latitude: latitude, longitude: longitude);
  }
}
