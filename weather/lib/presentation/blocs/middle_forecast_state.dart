import 'package:weather/domain/entities/middle_forecast_entity.dart';
import 'package:weather/presentation/blocs/base_state.dart';

abstract class MiddleForecastState extends BaseState {}

class MiddleForecastLoading extends MiddleForecastState {}

class MiddleForecastLoaded extends MiddleForecastState {
  final MiddleForecastEntity middleForecastEntity;

  MiddleForecastLoaded({required this.middleForecastEntity});
}

class MiddleForecastError extends MiddleForecastState {
  final String message;

  MiddleForecastError({required this.message});
}
