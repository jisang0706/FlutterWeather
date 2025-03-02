import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/presentation/blocs/base_event.dart';

abstract class WeatherEvent extends BaseEvent {}

class FetchWeather extends WeatherEvent {
  RegionEntity regionEntity;

  FetchWeather({required this.regionEntity});
}
