import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather/domain/entities/middle_forecast_entity.dart';
import 'package:weather/domain/usecase/get_middle_weather_usecase.dart';
import 'package:weather/presentation/blocs/middle_forecast_event.dart';
import 'package:weather/presentation/blocs/middle_forecast_state.dart';

// 중기예보 bloc
class MiddleForecastBloc
    extends Bloc<MiddleForecastEvent, MiddleForecastState> {
  final GetMiddleWeatherUsecase getMiddleWeatherUsecase;

  MiddleForecastBloc({required this.getMiddleWeatherUsecase})
      : super(MiddleForecastLoading()) {
    on<FetchMiddleForecast>(_fetchMiddleForecast);
  }

  Future<void> _fetchMiddleForecast(
      FetchMiddleForecast event, Emitter<MiddleForecastState> emit) async {
    emit(MiddleForecastLoading());

    try {
      final middleForecast = await _getMiddleForecaseInfo(
          dateTime: event.dateTime, middleRegionId: event.middleRegionId);

      emit(MiddleForecastLoaded(middleForecastEntity: middleForecast));
    } catch (e) {
      emit(MiddleForecastError(message: e.toString()));
    }
  }

  // 중기예보
  Future<MiddleForecastEntity> _getMiddleForecaseInfo(
      {required DateTime dateTime, required String middleRegionId}) async {
    final middleForecastResult = await getMiddleWeatherUsecase
        .getMiddleForecast(dateTime: dateTime, middleRegionId: middleRegionId);
    return middleForecastResult
        .getOrElse(() => MiddleForecastEntity.emptyEntity());
  }
}
