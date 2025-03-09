import 'package:weather/presentation/blocs/base_event.dart';

abstract class MiddleForecastEvent extends BaseEvent {}

class FetchMiddleForecast extends MiddleForecastEvent {
  final DateTime dateTime;
  final String middleRegionId;

  FetchMiddleForecast({required this.dateTime, required this.middleRegionId});
}
