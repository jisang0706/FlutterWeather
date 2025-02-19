import 'package:dartz/dartz.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/address_repository.dart';
import 'package:weather/domain/usecase/get_current_location_usecase.dart';

// 현 위치 검색을 위한 역지오코딩
class GetAddressUsecase {
  final AddressRepository repository;

  GetAddressUsecase({required this.repository});

  Future<Either<Failure, AddressEntity>> execute() async {
    final position = await GetCurrentLocationUsecase().execute();
    return await position.fold((failure) {
      return Left(failure);
    }, (position) {
      return repository.getAddress(
          latitude: position.latitude, longitude: position.longitude);
    });
  }
}
