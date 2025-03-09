import 'package:weather/data/datasources/middle_code_data_source.dart';
import 'package:weather/domain/repositories/middle_code_repository.dart';

// 지역 이름으로 중기예보 api에서 사용할 코드로 변환
class MiddleCodeRepositoryImpl implements MiddleCodeRepository {
  late final MiddleCodeDataSource middleRegionDataSource;

  MiddleCodeRepositoryImpl({required this.middleRegionDataSource});

  @override
  Future<String> getMiddleRegionIdByName(String middleRegion) async {
    return middleRegionDataSource.getMiddleRegionId(middleRegion);
  }
}
