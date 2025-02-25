import 'package:bloc/bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/usecase/get_address_usecase.dart';
import 'package:weather/domain/usecase/get_region_by_code_usecase.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/weather_event.dart';
import 'package:weather/presentation/blocs/weather_state.dart';

// 메인 페이지 bloc
class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final getAddressUsecase = GetIt.instance<GetAddressUsecase>();
  final getWeatherUsecase = GetIt.instance<GetWeatherUsecase>();
  final getRegionByCodeUsecase = GetIt.instance<GetRegionByCodeUsecase>();

  WeatherBloc() : super(WeatherLoading()) {
    on<FetchWeather>(_fetchWeather);
  }

  Future<void> _fetchWeather(
      FetchWeather event, Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try {
      final address = await getAddressUsecase.execute();
      final region =
          address.fold((failure) => "서울특별시", (address) => address.region3Depth);

      final regionEntity = await getRegionByCodeUsecase
          .execute(address.getOrElse(() => AddressEntity.emptyEntity()));

      final weather = await getWeatherUsecase.execute(regionEntity);
      final temperature = weather.fold((failure) => "error: ${failure.message}",
          (result) => "${result.t1h}°");
      final dateTime =
          weather.fold((failure) => "", (result) => result.dateTime);

      emit(WeatherLoaded(
          dateTime: dateTime, region: region, temperature: temperature));
    } catch (e) {
      emit(WeatherError(message: "날씨 정보를 불러오는 데 실패했습니다."));
    }
  }
}
