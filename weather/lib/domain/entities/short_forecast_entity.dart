import 'package:weather/core/utils/date_time_helper.dart';

// 단기예보 엔티티
class ShortForecastEntity {
  final double tmn; // 최저기온
  final double tmx; // 최고기온
  final DateTime dateTime;

  ShortForecastEntity(
      {required this.tmn, required this.tmx, required this.dateTime});

  factory ShortForecastEntity.fromJson(Map<String, dynamic> json) {
    final items = json["response"]["body"]["items"]["item"] as List;

    double? tmn, tmx;

    for (var item in items) {
      if (item["category"] == "TMN" && tmn == null) {
        tmn = double.tryParse(item["fcstValue"])!;
      } else if (item["category"] == "TMX" && tmx == null) {
        tmx = double.tryParse(item["fcstValue"])!;
      }
    }

    return ShortForecastEntity(
        tmn: tmn ?? 0,
        tmx: tmx ?? 0,
        dateTime: DateTimeHelper.stringToDateTime(
            date: items.first["fcstDate"], time: "0000"));
  }

  factory ShortForecastEntity.emptyEntity() {
    return ShortForecastEntity(
        tmn: 0,
        tmx: 0,
        dateTime:
            DateTimeHelper.stringToDateTime(date: "00000000", time: "0000"));
  }
}
