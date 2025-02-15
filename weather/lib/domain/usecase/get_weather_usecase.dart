import 'package:dio/dio.dart';

import '../../core/utils/date_time_helper.dart';
import '../../data/repository/weather_repository.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  late final WeatherRepository repository;

  GetWeatherUsecase(Dio dio) {
    repository = WeatherRepository(dio);
  }

  Future<String> execute() async {
    final String date = DateTimeHelper.getCurrentDate();
    final String time = DateTimeHelper.getCurrentTime();

    return await repository.getWeatherT1H(date: date, time: time);
  }
}
