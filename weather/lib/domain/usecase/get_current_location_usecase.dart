import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/data/repository/location_repository_impl.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/location_repository.dart';

// LocationRepository사용을 위한 UseCase
class GetCurrentLocationUsecase {
  final LocationRepository locationRepository;

  GetCurrentLocationUsecase({required this.locationRepository});

  Future<Either<Failure, Position>> execute() async {
    return await locationRepository.getCurrentLocation();
  }
}
