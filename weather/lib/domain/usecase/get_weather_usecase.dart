import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/data/repository/weather_repository.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';

// Weather Repository 사용을 위한 Usecase Class
class GetWeatherUsecase {
  late final WeatherRepository repository;

  GetWeatherUsecase() {
    repository = WeatherRepository();
  }

  Future<Either<Failure, String>> execute() async {
    final String date = DateTimeHelper.getCurrentDate();
    final String time = DateTimeHelper.getCurrentTime();

    // 역지오코딩 호출
    final Either<Failure, AddressEntity> temp = await GetAddressUsecase()
        .execute(latitude: 37.5360944444444, longitude: 126.967522222222);
    debugPrint(temp.fold((failure) => "fail: ${failure.message}",
        (address) => "success: ${address.addressName}"));

    return await repository.getWeatherT1H(date: date, time: time);
  }
}
