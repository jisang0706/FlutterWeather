import 'package:dartz/dartz.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/failures/failure.dart';

// 추상화
abstract class AddressRepository {
  Future<Either<Failure, AddressEntity>> getAddress(
      {required double latitude, required double longitude});
}
