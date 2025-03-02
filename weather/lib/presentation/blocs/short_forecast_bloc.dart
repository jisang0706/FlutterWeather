import 'package:bloc/bloc.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/short_forecast_entity.dart';
import 'package:weather/domain/usecase/get_weather_usecase.dart';
import 'package:weather/presentation/blocs/short_forecast_event.dart';
import 'package:weather/presentation/blocs/short_forecast_state.dart';

// 단기 예보 bloc
class ShortForecastBloc extends Bloc<ShortForecastEvent, ShortForecastState> {
  final GetWeatherUsecase getWeatherUsecase;

  ShortForecastBloc({required this.getWeatherUsecase})
      : super(ShortForecastLoading()) {
    on<FetchShortForecast>(_fetchShortForecast);
  }

  Future<void> _fetchShortForecast(
      FetchShortForecast event, Emitter<ShortForecastState> emit) async {
    emit(ShortForecastLoading());

    try {
      final shortForecast = await _getShortForecaseInfo(
          regionEntity: event.regionEntity, pageNo: event.pageNo);

      emit(ShortForecastLoaded(shortForecastEntity: shortForecast));
    } catch (e) {
      emit(ShortForecastError(message: e.toString()));
    }
  }

  // 단기예보
  Future<ShortForecastEntity> _getShortForecaseInfo(
      {required RegionEntity regionEntity, required int pageNo}) async {
    final shortForecastResult = await getWeatherUsecase.getShortForecase(
        regionEntity: regionEntity, pageNo: pageNo);
    return shortForecastResult
        .getOrElse(() => ShortForecastEntity.emptyEntity());
  }
}
