import 'package:weather/domain/entities/region_entity.dart';

abstract class ShortForecastEvent {}

class FetchShortForecast extends ShortForecastEvent {
  RegionEntity regionEntity;
  int pageNo;

  FetchShortForecast({required this.regionEntity, required this.pageNo});
}
