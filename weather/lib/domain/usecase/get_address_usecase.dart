import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/address_repository.dart';

// 현 위치 검색을 위한 역지오코딩
class GetAddressUsecase {
  final AddressRepository addressRepository;

  GetAddressUsecase({required this.addressRepository});

  Future<Either<Failure, AddressEntity>> execute(Position position) async {
    return await addressRepository.getAddress(
        latitude: position.latitude, longitude: position.longitude);
  }
}
