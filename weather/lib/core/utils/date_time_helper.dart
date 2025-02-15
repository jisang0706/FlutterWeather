class DateTimeHelper {
  static String getCurrentDate() {
    final now = DateTime.now();
    return "${now.year}${_twoDigits(now.month)}${_twoDigits(now.day)}";
  }

  static String getCurrentTime() {
    final now = DateTime.now();
    return "${_twoDigits(now.hour)}${_twoDigits(now.minute)}";
  }

  static String _twoDigits(int n) => n.toString().padLeft(2, '0');
}
