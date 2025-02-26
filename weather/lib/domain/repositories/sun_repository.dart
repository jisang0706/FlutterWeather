// 추상화
abstract class SunRepository {
  Future<DateTime> getSunriseTime(
      {required double latitude,
      required double longitude,
      required DateTime date});

  Future<DateTime> getSunsetTime(
      {required double latitude,
      required double longitude,
      required DateTime date});
}
