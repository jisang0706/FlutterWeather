import 'package:weather/presentation/blocs/base_state.dart';

abstract class SunTimesState extends BaseState {}

class SunTimesLoading extends SunTimesState {}

class SunTimesLoaded extends SunTimesState {
  final DateTime now;
  final DateTime sunrise;
  final DateTime sunset;

  SunTimesLoaded(
      {required this.now, required this.sunrise, required this.sunset});
}

class SunTimesError extends SunTimesState {
  final String message;
  SunTimesError({required this.message});
}
