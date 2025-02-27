import 'package:weather/presentation/blocs/base_event.dart';

abstract class LocationEvent extends BaseEvent {}

class FetchLocation extends LocationEvent {}
