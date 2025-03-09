import 'package:weather/domain/repositories/middle_code_repository.dart';

// MiddleCodeRepository사용을 위한 UseCase
class GetMiddleCodeByNameUsecase {
  final MiddleCodeRepository middleCodeRepository;

  GetMiddleCodeByNameUsecase({required this.middleCodeRepository});

  Future<String> execute({required String middleRegion}) async {
    return await middleCodeRepository.getMiddleRegionIdByName(middleRegion);
  }
}
