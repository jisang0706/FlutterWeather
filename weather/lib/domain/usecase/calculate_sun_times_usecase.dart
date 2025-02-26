import 'package:weather/domain/repositories/sun_repository.dart';

// 일출, 일몰 시간 계산
class CalculateSunTimesUsecase {
  final SunRepository sunRepository;

  CalculateSunTimesUsecase({required this.sunRepository});

  Future<DateTime> getSunriseTime(
      double latitude, double longitude, DateTime date) async {
    return sunRepository.getSunriseTime(
        latitude: latitude, longitude: longitude, date: date);
  }

  Future<DateTime> getSunsetTime(
      double latitude, double longitude, DateTime date) async {
    return sunRepository.getSunsetTime(
        latitude: latitude, longitude: longitude, date: date);
  }
}
