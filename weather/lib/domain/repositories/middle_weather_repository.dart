import 'package:dartz/dartz.dart';
import 'package:weather/domain/entities/middle_forecast_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// 추상화
abstract class MiddleWeatherRepository {
  Future<Either<Failure, MiddleForecastEntity>> getMiddleForecast(
      {required DateTime dateTime, required String middleRegionId});
}
