import 'dart:ui';

import 'package:flutter/material.dart';

// 배경 선택
class BackgroundPickHelper {
  static Color determineBackgroundColor(
      {required DateTime now,
      required DateTime sunrise,
      required DateTime sunset}) {
    final beforeSunrise = sunrise.subtract(const Duration(hours: 1));
    final afterSunrise = sunrise.add(const Duration(hours: 1));
    final beforeSunset = sunset.subtract(const Duration(hours: 1));
    final afterSunset = sunset.add(const Duration(minutes: 30));

    if (now.isBefore(beforeSunrise)) {
      // 한밤중 (일출 1시간 전까지)
      return const Color(0xFF0D1321);
    } else if (now.isBefore(sunrise)) {
      // 일출 직전 (~1시간 전)
      return Color(0xFF3D348B);
    } else if (now.isBefore(afterSunrise)) {
      // 일출 직후 (~1시간 후)
      return Color(0xFFFFA837);
    } else if (now.isBefore(beforeSunset)) {
      // 낮 (오전~오후)
      return Color(0xFF90E0EF);
    } else if (now.isBefore(sunset)) {
      // 일몰 직전 (~1시간 전)
      return Color(0xFFFF7043);
    } else if (now.isBefore(afterSunset)) {
      // 일몰 직후 (~1시간 후)
      return Color(0xFFC44536);
    } else {
      // 밤 (일몰 1시간 후부터 다음날 일출 1시간 전까지)
      return const Color(0xFF0D1321);
    }
  }
}
