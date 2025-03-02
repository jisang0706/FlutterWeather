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

    if (int.parse(time.substring(0, 2)) < 10) {
      final adjusted = DateTimeHelper.adjustTime(
          dateTime: DateTimeHelper.stringToDateTime(date: date, time: time),
          offsetMinutes: -1);
      {"date": date, "time": time} =
          DateTimeHelper.dateTimeToString(dateTime: adjusted);
    }

    return weatherRepository.getWeatherT1H(
        date: date, time: time, regionEntity: regionEntity);
  }
}
