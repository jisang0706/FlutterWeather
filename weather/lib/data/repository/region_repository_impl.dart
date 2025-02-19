import 'package:weather/data/datasources/region_data_source.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/repositories/region_repository.dart';

// 지역 코드로 날씨 api에서 사용할 좌표로 반환
class RegionRepositoryImpl implements RegionRepository {
  late final RegionDataSource regionDataSource;

  RegionRepositoryImpl({required this.regionDataSource});

  @override
  Future<RegionEntity> getRegionByName(AddressEntity addressEntity) async {
    return regionDataSource.getRegion(addressEntity);
  }
}
