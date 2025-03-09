import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/presentation/blocs/base_state.dart';

abstract class LocationState extends BaseState {}

class LocationLoading extends LocationState {}

class LocationLoaded extends LocationState {
  final String region;
  final RegionEntity regionEntity;
  final String middleRegionId;

  LocationLoaded(
      {required this.region,
      required this.regionEntity,
      required this.middleRegionId});
}

class LocationError extends LocationState {
  final String message;
  LocationError({required this.message});
}
