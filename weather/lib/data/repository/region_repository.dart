import 'package:weather/data/datasources/region_data_source.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';

// 지역 코드로 날씨 api에서 사용할 좌표로 반환
class RegionRepository {
  late final RegionDataSource dataSource;

  RegionRepository() {
    dataSource = RegionDataSource();
  }

  Future<RegionEntity> getRegionByName(AddressEntity addressEntity) async {
    return dataSource.getRegion(addressEntity);
  }
}
