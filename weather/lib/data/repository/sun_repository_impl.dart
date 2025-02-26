import 'dart:math';

import 'package:logging/logging.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/domain/repositories/sun_repository.dart';

// 좌표, 날짜로 일출 일몰 시간 계산
class SunRepositoryImpl implements SunRepository {
  @override
  Future<DateTime> getSunriseTime(
      {required double latitude,
      required double longitude,
      required DateTime date}) async {
    return _calculateSunTime(latitude, longitude, date, isSunrise: true);
  }

  @override
  Future<DateTime> getSunsetTime(
      {required double latitude,
      required double longitude,
      required DateTime date}) async {
    return _calculateSunTime(latitude, longitude, date, isSunrise: false);
  }

  DateTime _calculateSunTime(double latitude, double longitude, DateTime date,
      {required bool isSunrise}) {
    var logger = Logger('SunRepository');

    if (isSunrise) {
      date = DateTimeHelper.adjustDay(dateTime: date, offsetDay: -1);
    }

    const double zenith = 90.8333;
    final int year = date.year;
    final int month = date.month;
    final int day = date.day;

    final int N = _calculateJulianDay(year, month, day);

    double M = (0.9856 * N) - 3.289;

    double L = M +
        (1.916 * sin(_degToRad(M))) +
        (0.020 * sin(_degToRad(2 * M))) +
        282.634;
    L = _normalizeAngle(L);

    double RA = _radToDeg(atan(0.91764 * tan(_degToRad(L))));
    RA = _normalizeAngle(RA);

    final double lquadrant = (L ~/ 90) * 90.0;
    final double rAquadrant = (RA ~/ 90) * 90.0;
    RA = RA + (lquadrant - rAquadrant);
    RA = RA / 15;

    double sinDec = 0.39782 * sin(_degToRad(L));
    double cosDec = cos(asin(sinDec));

    double cosH =
        (cos(_degToRad(zenith)) - (sinDec * sin(_degToRad(latitude)))) /
            (cosDec * cos(_degToRad(latitude)));

    if (cosH > 1) {
      throw Exception("Polar Night: The sun never rises on this location.");
    } else if (cosH < -1) {
      throw Exception("Midnight Sun: The sun never sets on this location.");
    }

    double H = isSunrise ? 360 - _radToDeg(acos(cosH)) : _radToDeg(acos(cosH));
    H /= 15;

    double T = H + RA - (0.06571 * N) - 6.622;
    double UT = _normalizeHour(T - longitude / 15);

    DateTime result = DateTime.utc(
      year,
      month,
      day,
      UT.toInt(),
      ((UT - UT.toInt()) * 60).toInt(),
    ).toLocal();

    logger
        .info('${isSunrise ? 'Sunrise' : 'Sunset'} calculated: $result (KST)');

    return result;
  }

  static int _calculateJulianDay(int year, int month, int day) {
    return ((275 * month) / 9).floor() -
        (((month + 9) / 12).floor() *
            ((year + (year / 4).floor() + 2) / 3).floor()) +
        day -
        30;
  }

  /// 각도를 0~360 사이로 정규화
  static double _normalizeAngle(double angle) {
    while (angle < 0) {
      angle += 360;
    }
    while (angle >= 360) {
      angle -= 360;
    }
    return angle;
  }

  /// 시간을 0~24 사이로 정규화
  static double _normalizeHour(double hour) {
    while (hour < 0) {
      hour += 24;
    }
    while (hour >= 24) {
      hour -= 24;
    }
    return hour;
  }

  /// 각도를 라디안으로 변환
  static double _degToRad(double deg) {
    return deg * pi / 180.0;
  }

  /// 라디안을 각도로 변환
  static double _radToDeg(double rad) {
    return rad * 180.0 / pi;
  }
}
