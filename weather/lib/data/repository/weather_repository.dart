import 'package:weather/data/datasources/weather_remote_data_source.dart';

// WeatherRemoteDataSource에서 데이터 받은 뒤 가공
class WeatherRepository {
  Future<String> getWeatherT1H(
      {required String date, required String time}) async {
    final data = await WeatherRemoteDataSource()
        .getCurrentWeather(baseDate: date, baseTime: time);

    final t1hValue = (data["response"]["body"]["items"]["item"] as List)
        .where((item) => item["category"] == "T1H")
        .firstOrNull?["obsrValue"];

    return "$t1hValue도";
  }
}
