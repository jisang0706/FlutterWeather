import 'package:dartz/dartz.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// WeatherRemoteDataSource에서 데이터 받은 뒤 엔티티로 반환
class WeatherRepository {
  Future<Either<Failure, WeatherEntity>> getWeatherT1H(
      {required String date,
      required String time,
      required RegionEntity regionEntity}) async {
    try {
      final data = await WeatherRemoteDataSource().getCurrentWeather(
          baseDate: date, baseTime: time, regionEntity: regionEntity);

      return Right(WeatherEntity.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
