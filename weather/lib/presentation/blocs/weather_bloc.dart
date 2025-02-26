import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/usecase/calculate_sun_times_usecase.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_current_location_usecase.dart';
import 'package:weather/domain/usecase/get_region_by_code_usecase.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/weather_event.dart';
import 'package:weather/presentation/blocs/weather_state.dart';

// 메인 페이지 bloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final getCurrentLocationUsecase = GetIt.instance<GetCurrentLocationUsecase>();
  final getAddressUsecase = GetIt.instance<GetAddressUsecase>();
  final getWeatherUsecase = GetIt.instance<GetWeatherUsecase>();
  final getRegionByCodeUsecase = GetIt.instance<GetRegionByCodeUsecase>();
  final calculateSunTimesUsecase = GetIt.instance<CalculateSunTimesUsecase>();

  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeather>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final position = await getCurrentLocationUsecase.execute();
      final Either<Failure, AddressEntity> address = await position.fold(
          (failure) => Left(failure),
          (position) => getAddressUsecase.execute(position));
      final region =
          address.fold((failure) => "서울특별시", (address) => address.region3Depth);

      final regionEntity = await getRegionByCodeUsecase
          .execute(address.getOrElse(() => AddressEntity.emptyEntity()));

      var now = DateTimeHelper.getCurrentDateTime();
      final sunrise = await position.fold(
          (failure) =>
              calculateSunTimesUsecase.getSunriseTime(37.5665, 126.9780, now),
          (position) => calculateSunTimesUsecase.getSunriseTime(
              position.latitude, position.longitude, now));
      final sunset = await position.fold(
          (failure) =>
              calculateSunTimesUsecase.getSunsetTime(37.5665, 126.9780, now),
          (position) => calculateSunTimesUsecase.getSunsetTime(
              position.latitude, position.longitude, now));

      final weather = await getWeatherUsecase.execute(regionEntity);
      final temperature = weather.fold((failure) => "error: ${failure.message}",
          (result) => "${result.t1h}°");
      final dateTime =
          weather.fold((failure) => "", (result) => result.dateTime);
      final backgroundColor = _determineBackgroundColor(now, sunrise, sunset);

      emit(WeatherLoaded(
          dateTime: dateTime,
          region: region,
          temperature: temperature,
          backgroundColor: backgroundColor));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }

  Color _determineBackgroundColor(
      DateTime now, DateTime sunrise, DateTime sunset) {
    final beforeSunrise = sunrise.subtract(const Duration(hours: 1));
    final afterSunrise = sunrise.add(const Duration(hours: 1));
    final beforeSunset = sunset.subtract(const Duration(hours: 1));
    final afterSunset = sunset.add(const Duration(minutes: 30));

    if (now.isBefore(beforeSunrise)) {
      // 한밤중 (일출 1시간 전까지)
      return const Color.fromARGB(255, 21, 3, 51);
    } else if (now.isBefore(sunrise)) {
      // 일출 직전 (~1시간 전)
      return Colors.indigo.shade700;
    } else if (now.isBefore(afterSunrise)) {
      // 일출 직후 (~1시간 후)
      return Colors.orangeAccent;
    } else if (now.isBefore(beforeSunset)) {
      // 낮 (오전~오후)
      return Colors.lightBlueAccent;
    } else if (now.isBefore(sunset)) {
      // 일몰 직전 (~1시간 전)
      return Colors.orangeAccent;
    } else if (now.isBefore(afterSunset)) {
      // 일몰 직후 (~1시간 후)
      return Colors.deepOrangeAccent;
    } else {
      // 밤 (일몰 1시간 후부터 다음날 일출 1시간 전까지)
      return const Color.fromARGB(255, 21, 3, 51);
    }
  }
}
