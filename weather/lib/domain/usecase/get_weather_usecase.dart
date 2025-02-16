import 'dart:developer';

import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';

import '../../core/utils/date_time_helper.dart';
import '../../data/repository/weather_repository.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  late final WeatherRepository repository;

  GetWeatherUsecase() {
    repository = WeatherRepository();
  }

  Future<String> execute() async {
    final String date = DateTimeHelper.getCurrentDate();
    final String time = DateTimeHelper.getCurrentTime();

    // 역지오코딩 호출
    final AddressEntity temp = await GetAddressUsecase()
        .execute(latitude: 37.5360944444444, longitude: 126.967522222222);
    log(temp.region2Depth);

    return await repository.getWeatherT1H(date: date, time: time);
  }
}
