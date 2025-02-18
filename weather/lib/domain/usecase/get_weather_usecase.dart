import 'package:dartz/dartz.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/data/repository/weather_repository.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  late final WeatherRepository repository;

  GetWeatherUsecase() {
    repository = WeatherRepository();
  }

  Future<Either<Failure, WeatherEntity>> execute() async {
    final String date = DateTimeHelper.getCurrentDate();
    final String time = DateTimeHelper.getCurrentTime();

    return await repository.getWeatherT1H(date: date, time: time);
  }
}
