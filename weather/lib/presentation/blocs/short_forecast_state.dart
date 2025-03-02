import 'package:weather/domain/entities/short_forecast_entity.dart';

abstract class ShortForecastState {}

class ShortForecastLoading extends ShortForecastState {}

class ShortForecastLoaded extends ShortForecastState {
  final ShortForecastEntity shortForecastEntity;

  ShortForecastLoaded({required this.shortForecastEntity});
}

class ShortForecastError extends ShortForecastState {
  final String message;
  ShortForecastError({required this.message});
}
