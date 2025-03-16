import 'package:weather/presentation/blocs/base_state.dart';

abstract class WeatherState extends BaseState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final String dateTime;
  final double temperature;

  WeatherLoaded({
    required this.dateTime,
    required this.temperature,
  });
}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}
