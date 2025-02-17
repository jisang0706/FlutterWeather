import 'package:dartz/dartz.dart';
import 'package:weather/core/exception/server_exception.dart';
import 'package:weather/data/datasources/address_remote_data_source.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// 역지오코딩 응답 엔티티로 반환
class AddressRepository {
  Future<Either<Failure, AddressEntity>> getAddress(
      {required double latitude, required double longitude}) async {
    try {
      final data = await AddressRemoteDataSource()
          .getAddressFromCoordinates(latitude: latitude, longitude: longitude);
      return Right(AddressEntity.fromJson(data));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }
}
