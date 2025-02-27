// 메인 페이지 Bloc 패턴을 위한 상태 클래스
abstract class WeatherState {}

// 로딩
class WeatherLoading extends WeatherState {}

// 성공
class WeatherLoaded extends WeatherState {
  final String dateTime;
  final String region;
  final String temperature;
  final DateTime now;
  final DateTime sunrise;
  final DateTime sunset;

  WeatherLoaded(
      {required this.dateTime,
      required this.region,
      required this.temperature,
      required this.now,
      required this.sunrise,
      required this.sunset});
}

// 실패
class WeatherError extends WeatherState {
  final String message;
  WeatherError({required this.message});
}
