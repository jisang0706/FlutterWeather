import 'package:logging/logging.dart';

class LogHelper {
  static void log(String message) {
    var logger = Logger("");
    logger.info(message);
  }
}
