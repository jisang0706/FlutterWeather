// 날씨 엔티티
class WeatherEntity {
  final double t1h; // 기온
  final double rn1; // 1시간 강수량
  final double uuu; // 동서바람성분
  final double vvv; // 남북바람성분
  final double reh; // 습도
  final double pty; // 강수형태
  final double vec; // 풍향
  final double wsd; // 풍속

  WeatherEntity(
      {required this.t1h,
      required this.rn1,
      required this.uuu,
      required this.vvv,
      required this.reh,
      required this.pty,
      required this.vec,
      required this.wsd});

  factory WeatherEntity.fromJson(Map<String, dynamic> json) {
    final items = json["response"]["body"]["items"]["item"] as List;

    final Map<String, double?> weatherMap = {
      for (var item in items) item["category"]: item["obsrValue"]
    };

    return WeatherEntity(
        t1h: weatherMap["T1H"] ?? 0,
        rn1: weatherMap["RN1"] ?? 0,
        uuu: weatherMap["UUU"] ?? 0,
        vvv: weatherMap["VVV"] ?? 0,
        reh: weatherMap["REF"] ?? 0,
        pty: weatherMap["PTY"] ?? 0,
        vec: weatherMap["VEC"] ?? 0,
        wsd: weatherMap["WSD"] ?? 0);
  }
}
