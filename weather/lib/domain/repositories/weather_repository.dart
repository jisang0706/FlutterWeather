import 'package:dartz/dartz.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// 추상화
abstract class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherT1H(
      {required String date,
      required String time,
      required RegionEntity regionEntity});
}
