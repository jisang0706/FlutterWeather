import 'package:dartz/dartz.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/core/exception/location_exception.dart';
import 'package:weather/data/datasources/location_data_source.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/location_repository.dart';

// 사용자 위치 반환
class LocationRepositoryImpl implements LocationRepository {
  final LocationDataSource locationDataSource;

  LocationRepositoryImpl({required this.locationDataSource});

  @override
  Future<Either<Failure, Position>> getCurrentLocation() async {
    try {
      final position = await LocationDataSource().getCurrentLocation();
      return Right(position);
    } on LocationException catch (e) {
      return Left(LocationFailure(message: e.message));
    }
  }
}
