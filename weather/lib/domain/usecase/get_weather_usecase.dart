import 'package:dartz/dartz.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  final WeatherRepository weatherRepository;

  GetWeatherUsecase({required this.weatherRepository});

  Future<Either<Failure, WeatherEntity>> execute(
      RegionEntity regionEntity) async {
    String date = DateTimeHelper.getCurrentDate();
    String time = DateTimeHelper.getCurrentTime();

    var result = await weatherRepository.getWeatherT1H(
        date: date, time: time, regionEntity: regionEntity);

    if (result.isLeft()) {
      {"date": date, "time": time} =
          DateTimeHelper.adjustTime(date: date, time: time, offsetMinutes: -1);

      return await weatherRepository.getWeatherT1H(
          date: date, time: time, regionEntity: regionEntity);
    }
    return result;
  }
}
