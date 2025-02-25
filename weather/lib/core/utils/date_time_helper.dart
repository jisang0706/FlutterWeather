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

  // 시간 +-
  static Map<String, String> adjustTime(
      {required String date,
      required String time,
      required int offsetMinutes}) {
    DateTime dateTime = DateTime.parse("$date $time");
    dateTime = dateTime.add(Duration(hours: offsetMinutes));

    return {"date": dateFormat(dateTime), "time": timeFormat(dateTime)};
  }

  // datetime 포멧 변경
  static String formatToReadable({required String date, required String time}) {
    DateTime dateTime = DateTime.parse("$date $time");
    final DateFormat formatter = DateFormat("M월 d일\na h시", "ko_KR");

    return formatter.format(dateTime);
  }

  static String dateFormat(DateTime dateTime) {
    return "${dateTime.year}${_twoDigits(dateTime.month)}${_twoDigits(dateTime.day)}";
  }

  static String timeFormat(DateTime dateTime) {
    return "${_twoDigits(dateTime.hour)}${_twoDigits(dateTime.minute)}";
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
