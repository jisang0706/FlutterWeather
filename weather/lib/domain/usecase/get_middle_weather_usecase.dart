import 'package:dartz/dartz.dart';
import 'package:weather/domain/entities/middle_forecast_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/middle_weather_repository.dart';

// 중기예보 Repository 사용을 위한 Usecase Class
class GetMiddleWeatherUsecase {
  final MiddleWeatherRepository middleWeatherRepository;

  GetMiddleWeatherUsecase({required this.middleWeatherRepository});

  // 중기 예보
  Future<Either<Failure, MiddleForecastEntity>> getMiddleForecast(
      {required DateTime dateTime, required String middleRegionId}) async {
    return middleWeatherRepository.getMiddleForecast(
        dateTime: dateTime, middleRegionId: middleRegionId);
  }
}
