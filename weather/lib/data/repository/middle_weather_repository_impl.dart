import 'package:dartz/dartz.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/core/utils/date_time_helper.dart';
import 'package:weather/data/datasources/middle_weather_remote_data_source.dart';
import 'package:weather/domain/entities/middle_forecast_entity.dart';
import 'package:weather/domain/failures/failure.dart';
import 'package:weather/domain/repositories/middle_weather_repository.dart';

class MiddleWeatherRepositoryImpl implements MiddleWeatherRepository {
  final MiddleWeatherRemoteDataSource middleWeatherRemoteDataSource;

  MiddleWeatherRepositoryImpl({required this.middleWeatherRemoteDataSource});

  // 중기예보
  @override
  Future<Either<Failure, MiddleForecastEntity>> getMiddleForecast(
      {required DateTime dateTime, required String middleRegionId}) async {
    try {
      Map<String, String> dateTimeMap =
          DateTimeHelper.dateTimeToString(dateTime: dateTime);
      String dateTimeString = dateTimeMap["date"]! + dateTimeMap["time"]!;
      Map<String, dynamic> data = await middleWeatherRemoteDataSource
          .getMiddleFcst(dateTime: dateTimeString, regId: middleRegionId);

      if (!isDataAvailable(data)) {
        return Left(
            NoDataFailure(message: data["response"]["header"]["resultMsg"]));
      }
      final middleForecastEntity = MiddleForecastEntity.fromJson(data);
      if (dateTime.hour >= 18) {
        dateTime = DateTimeHelper.getMiddleFixedTime(
            DateTimeHelper.adjustTime(dateTime: dateTime, offsetHours: -6));
        dateTimeMap = DateTimeHelper.dateTimeToString(dateTime: dateTime);
        dateTimeString = dateTimeMap["date"]! + dateTimeMap["time"]!;

        Map<String, dynamic> pastData = await middleWeatherRemoteDataSource
            .getMiddleFcst(dateTime: dateTimeString, regId: middleRegionId);
        final pastMiddleForecastEntity =
            MiddleForecastEntity.fromJson(pastData);
        middleForecastEntity.setTa4(
            pastMiddleForecastEntity.taMin4!, pastMiddleForecastEntity.taMax4!);
      }
      return Right(middleForecastEntity);
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
