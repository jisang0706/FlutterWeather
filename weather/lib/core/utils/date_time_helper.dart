import 'package:intl/intl.dart';

class DateTimeHelper {
  static String getCurrentDate() {
    final now = DateTime.now();
    return dateFormat(now);
  }

  static String getCurrentTime() {
    final now = DateTime.now();
    return timeFormat(now);
  }

  static DateTime getCurrentDateTime() {
    return DateTime.now();
  }

  static DateTime stringToDateTime(
      {required String date, required String time}) {
    return DateTime.parse("$date $time");
  }

  static Map<String, String> dateTimeToString({required DateTime dateTime}) {
    return {"date": dateFormat(dateTime), "time": timeFormat(dateTime)};
  }

  // 시간 +-
  static DateTime adjustTime(
      {required DateTime dateTime, required int offsetHours}) {
    return dateTime.add(Duration(hours: offsetHours));
  }

  // 날짜 +-
  static DateTime adjustDay(
      {required DateTime dateTime, required int offsetDay}) {
    return dateTime.add(Duration(days: offsetDay));
  }

  // 날짜 차이
  static int calculateDayDiffrence(
      {required DateTime from, required DateTime to}) {
    final fromDate = DateTime(from.year, from.month, from.day);
    final toDate = DateTime(to.year, to.month, to.day);

    return toDate.difference(fromDate).inDays;
  }

  // 중기예보에서 요구하는 시간으로 변경
  static DateTime getMiddleFixedTime(DateTime dateTime) {
    int hour = dateTime.hour;

    if (hour < 6) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day - 1, 18, 0);
    } else if (hour < 18) {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, 6, 0);
    } else {
      return DateTime(dateTime.year, dateTime.month, dateTime.day, 18, 0);
    }
  }

  // datetime 포멧 변경
  static String formatToReadable({required String date, required String time}) {
    DateTime dateTime = DateTime.parse("$date $time");
    final DateFormat formatter = DateFormat("M월 d일\na h시", "ko_KR");

    return formatter.format(dateTime);
  }

  static String timeToReadable({required String time}) {
    int hour = int.parse(time.substring(0, 2));
    return "${hour < 12 ? "오전" : "오후"} ${hour % 12 == 0 ? 12 : hour % 12}시";
  }

  static String dateToReadable({required DateTime dateTime}) {
    return "${dateTime.month}.${dateTime.day}";
  }

  static String dateFormat(DateTime dateTime) {
    return "${dateTime.year}${_twoDigits(dateTime.month)}${_twoDigits(dateTime.day)}";
  }

  static String timeFormat(DateTime dateTime) {
    return "${_twoDigits(dateTime.hour)}${_twoDigits(dateTime.minute)}";
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
