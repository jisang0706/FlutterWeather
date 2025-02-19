import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';
import 'package:weather/domain/repositories/region_repository.dart';

// RegionRepository사용을 위한 UseCase
class GetRegionByCodeUsecase {
  final RegionRepository regionRepository;

  GetRegionByCodeUsecase({required this.regionRepository});

  Future<RegionEntity> execute(AddressEntity addressEntity) async {
    return await regionRepository.getRegionByName(addressEntity);
  }
}
