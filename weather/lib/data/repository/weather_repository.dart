import 'package:dartz/dartz.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather/domain/failures/failure.dart';

// WeatherRemoteDataSource에서 데이터 받은 뒤 가공
class WeatherRepository {
  Future<Either<Failure, String>> getWeatherT1H(
      {required String date, required String time}) async {
    try {
      final data = await WeatherRemoteDataSource()
          .getCurrentWeather(baseDate: date, baseTime: time);

      final t1hValue = (data["response"]["body"]["items"]["item"] as List)
          .where((item) => item["category"] == "T1H")
          .firstOrNull?["obsrValue"];

      return Right("$t1hValue도");
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
