import 'package:dartz/dartz.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/short_forecast_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  final WeatherRepository weatherRepository;

  GetWeatherUsecase({required this.weatherRepository});

  // 현재 날씨
  Future<Either<Failure, WeatherEntity>> getWeather(
      RegionEntity regionEntity) async {
    DateTime dateTime = DateTimeHelper.getCurrentDateTime();
    String date = DateTimeHelper.dateFormat(dateTime);
    String time = DateTimeHelper.timeFormat(dateTime);

    if (int.parse(time.substring(2, 4)) < 10) {
      final adjusted =
          DateTimeHelper.adjustTime(dateTime: dateTime, offsetHours: -1);
      {"date": date, "time": time} =
          DateTimeHelper.dateTimeToString(dateTime: adjusted);
    }

    return weatherRepository.getWeatherT1H(
        date: date, time: time, regionEntity: regionEntity);
  }

  // 단기 예보
  Future<Either<Failure, ShortForecastEntity>> getShortForecase(
      {required RegionEntity regionEntity, required int pageNo}) async {
    DateTime yesterday = DateTimeHelper.adjustDay(
        dateTime: DateTimeHelper.getCurrentDateTime(), offsetDay: -1);

    return weatherRepository.getShortForecast(
        dateTime: yesterday, regionEntity: regionEntity, pageNo: pageNo);
  }
}
