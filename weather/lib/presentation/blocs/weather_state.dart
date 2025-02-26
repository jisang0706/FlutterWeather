// 메인 페이지 Bloc 패턴을 위한 상태 클래스
import 'dart:ui';

abstract class WeatherState {}

// 로딩
class WeatherLoading extends WeatherState {}

// 성공
class WeatherLoaded extends WeatherState {
  final String dateTime;
  final String region;
  final String temperature;
  final Color backgroundColor;

  WeatherLoaded(
      {required this.dateTime,
      required this.region,
      required this.temperature,
      required this.backgroundColor});
}

// 실패
class WeatherError extends WeatherState {
  final String message;
  WeatherError({required this.message});
}
