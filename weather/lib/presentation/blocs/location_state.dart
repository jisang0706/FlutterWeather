import 'package:weather/presentation/blocs/base_state.dart';

abstract class LocationState extends BaseState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String region;
  LocationLoaded({required this.region});
}

class LocationError extends LocationState {
  final String message;
  LocationError({required this.message});
}
