import 'package:dartz/dartz.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  final WeatherRepository repository;

  GetWeatherUsecase({required this.repository});

  Future<Either<Failure, WeatherEntity>> execute(
      RegionEntity regionEntity) async {
    final String date = DateTimeHelper.getCurrentDate();
    final String time = DateTimeHelper.getCurrentTime();

    return await repository.getWeatherT1H(
        date: date, time: time, regionEntity: regionEntity);
  }
}
