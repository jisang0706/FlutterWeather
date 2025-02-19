import 'package:weather/data/repository/region_repository.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';

// RegionRepository사용을 위한 UseCase
class GetRegionByNameUsecase {
  late final RegionRepository repository;

  GetRegionByNameUsecase() {
    repository = RegionRepository();
  }

  Future<RegionEntity> execute(AddressEntity addressEntity) async {
    return await repository.getRegionByName(addressEntity);
  }
}
