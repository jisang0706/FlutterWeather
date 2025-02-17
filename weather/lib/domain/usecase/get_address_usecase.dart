import 'package:dartz/dartz.dart';
import 'package:weather/data/repository/address_repository.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// 현 위치 검색을 위한 역지오코딩
class GetAddressUsecase {
  late final AddressRepository repository;

  GetAddressUsecase() {
    repository = AddressRepository();
  }

  Future<Either<Failure, AddressEntity>> execute(
      {required double latitude, required double longitude}) async {
    return await repository.getAddress(
        latitude: latitude, longitude: longitude);
  }
}
