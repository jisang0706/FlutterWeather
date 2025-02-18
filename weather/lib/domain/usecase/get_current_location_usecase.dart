import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/repository/location_repository.dart';
import 'package:weather/domain/failures/failure.dart';

// LocationRepository사용을 위한 UseCase
class GetCurrentLocationUsecase {
  late final LocationRepository repository;

  GetCurrentLocationUsecase() {
    repository = LocationRepository();
  }

  Future<Either<Failure, Position>> execute() async {
    return await repository.getCurrentLocation();
  }
}
