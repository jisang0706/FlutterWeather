import 'package:dartz/dartz.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/data/datasources/weather_remote_data_source.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/entities/short_forecast_entity.dart';
import 'package:weather/domain/entities/weather_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/weather_repository.dart';

// WeatherRemoteDataSource에서 데이터 받은 뒤 엔티티로 반환
class WeatherRepositoryImpl implements WeatherRepository {
  final WeatherRemoteDataSource weatherRemoteDataSource;

  WeatherRepositoryImpl({required this.weatherRemoteDataSource});

  // 현재 날씨
  @override
  Future<Either<Failure, WeatherEntity>> getWeatherT1H(
      {required String date,
      required String time,
      required RegionEntity regionEntity}) async {
    try {
      Map<String, dynamic> data =
          await weatherRemoteDataSource.getCurrentWeather(
              baseDate: date, baseTime: time, regionEntity: regionEntity);

      if (!isDataAvailable(data)) {
        return Left(
            NoDataFailure(message: data["response"]["header"]["resultMsg"]));
      }

      return Right(WeatherEntity.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(NormalFailure(message: e.toString()));
    }
  }

  // 단기예보
  @override
  Future<Either<Failure, ShortForecastEntity>> getShortForecase(
      {required DateTime dateTime,
      required RegionEntity regionEntity,
      required int pageNo}) async {
    try {
      Map<String, dynamic> data = await weatherRemoteDataSource.getVilageFcst(
          dateTime: dateTime, regionEntity: regionEntity, pageNo: pageNo);

      if (!isDataAvailable(data)) {
        return Left(
            NoDataFailure(message: data["response"]["header"]["resultMsg"]));
      }
      return Right(ShortForecastEntity.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    } catch (e) {
      return Left(NormalFailure(message: e.toString()));
    }
  }

  bool isDataAvailable(Map<String, dynamic> data) {
    return data["response"]["header"]["resultCode"] == "00";
  }
}
