import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';

// 추상화
abstract class RegionRepository {
  Future<RegionEntity> getRegionByName(AddressEntity addressEntity);
}
