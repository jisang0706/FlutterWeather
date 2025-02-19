import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/domain/failures/failure.dart';

// 추상화
abstract class LocationRepository {
  Future<Either<Failure, Position>> getCurrentLocation();
}
