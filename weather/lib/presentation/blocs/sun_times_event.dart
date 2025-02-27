import 'package:dartz/dartz.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/presentation/blocs/base_event.dart';

abstract class SunTimesEvent extends BaseEvent {}

class FetchSunTimes extends SunTimesEvent {
  Either<Failure, dynamic> position;

  FetchSunTimes({required this.position});
}
