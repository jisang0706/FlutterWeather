import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/presentation/blocs/base_state.dart';

abstract class LocationState extends BaseState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String region;
  final RegionEntity regionEntity;
  LocationLoaded({required this.region, required this.regionEntity});
}

class LocationError extends LocationState {
  final String message;
  LocationError({required this.message});
}
