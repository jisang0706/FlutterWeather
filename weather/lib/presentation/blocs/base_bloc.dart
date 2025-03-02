import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/usecase/calculate_sun_times_usecase.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_current_location_usecase.dart';
import 'package:weather/domain/usecase/get_region_by_code_usecase.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/base_event.dart';
import 'package:weather/presentation/blocs/base_state.dart';
import 'package:weather/presentation/blocs/location_event.dart';
import 'package:weather/presentation/blocs/location_state.dart';
import 'package:weather/presentation/blocs/sun_times_event.dart';
import 'package:weather/presentation/blocs/sun_times_state.dart';
import 'package:weather/presentation/blocs/weather_event.dart';
import 'package:weather/presentation/blocs/weather_state.dart';

// 메인 페이지 bloc
class BaseBloc extends Bloc<BaseEvent, BaseState> {
  final GetCurrentLocationUsecase getCurrentLocationUsecase;
  final GetAddressUsecase getAddressUsecase;
  final GetWeatherUsecase getWeatherUsecase;
  final GetRegionByCodeUsecase getRegionByCodeUsecase;
  final CalculateSunTimesUsecase calculateSunTimesUsecase;

  BaseBloc(
      {required this.getCurrentLocationUsecase,
      required this.getAddressUsecase,
      required this.getWeatherUsecase,
      required this.getRegionByCodeUsecase,
      required this.calculateSunTimesUsecase})
      : super(BaseLoading()) {
    on<FetchBase>(_fetchBase);
    on<FetchLocation>(_fetchLocation);
    on<FetchSunTimes>(_fetchSunTimes);
    on<FetchWeather>(_fetchWeather);
  }

  Future<void> _fetchBase(FetchBase event, Emitter<BaseState> emit) async {
    emit(BaseLoading());

    add(FetchLocation());
  }

  Future<void> _fetchLocation(
      FetchLocation event, Emitter<BaseState> emit) async {
    emit(LocationLoading());

    try {
      final position = await _getCurrentPosition();
      final address = await _getAddressFromPosition(position);
      final regionEntity = await _getRegionEntity(address);

      emit(LocationLoaded(
          region: address.region3Depth, regionEntity: regionEntity));

      add(FetchSunTimes(position: position));
      add(FetchWeather(regionEntity: regionEntity));
    } catch (e) {
      emit(LocationError(message: e.toString()));
    }
  }

  Future<void> _fetchSunTimes(
      FetchSunTimes event, Emitter<BaseState> emit) async {
    emit(SunTimesLoading());

    try {
      final now = DateTimeHelper.getCurrentDateTime();
      final sunTimes = await _getSunTimes(event.position, now);

      emit(SunTimesLoaded(now: now, sunrise: sunTimes.$1, sunset: sunTimes.$2));
    } catch (e) {
      emit(SunTimesError(message: e.toString()));
    }
  }

  Future<void> _fetchWeather(
      FetchWeather event, Emitter<BaseState> emit) async {
    emit(WeatherLoading());

    try {
      final weather = await _getWeatherInfo(event.regionEntity);

      emit(WeatherLoaded(
        dateTime: weather.time,
        temperature: "${weather.t1h}",
      ));
    } catch (e) {
      emit(WeatherError(message: e.toString()));
    }
  }

  // 현재 좌표
  Future<Either<Failure, dynamic>> _getCurrentPosition() async {
    return await getCurrentLocationUsecase.execute();
  }

  // 현재 주소
  Future<AddressEntity> _getAddressFromPosition(
      Either<Failure, dynamic> position) async {
    final Either<Failure, AddressEntity> addressResult = await position.fold(
        (failure) => Left(failure),
        (position) => getAddressUsecase.execute(position));
    return addressResult.getOrElse(() => AddressEntity.emptyEntity());
  }

  // 주소 코드
  Future<RegionEntity> _getRegionEntity(AddressEntity address) async {
    return await getRegionByCodeUsecase.execute(address);
  }

  // 일출, 일몰시간
  Future<(DateTime, DateTime)> _getSunTimes(
      Either<Failure, dynamic> position, DateTime now) async {
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

    return (sunrise, sunset);
  }

  // 현재 날씨
  Future<WeatherEntity> _getWeatherInfo(RegionEntity regionEntity) async {
    final weatherResult = await getWeatherUsecase.getWeather(regionEntity);
    return weatherResult.getOrElse(() => WeatherEntity.emptyEntity());
  }
}
