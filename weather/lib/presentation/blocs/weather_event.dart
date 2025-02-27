import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/presentation/blocs/base_event.dart';

abstract class WeatherEvent extends BaseEvent {}

class FetchWeather extends WeatherEvent {
  AddressEntity address;

  FetchWeather({required this.address});
}
