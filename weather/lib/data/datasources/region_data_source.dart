import 'package:excel/excel.dart';
import 'package:flutter/services.dart';
import 'package:weather/domain/entities/address_entity.dart';
import 'package:weather/domain/entities/region_entity.dart';

// 지역 코드로 region 파일에서 날씨 api에 사용할 좌표 가져옴
class RegionDataSource {
  final Map<String, RegionEntity> _regionMap = {};

  RegionDataSource() {
    loadExcelData();
  }

  // 파일 불러와서 Map에 저장
  Future<void> loadExcelData() async {
    ByteData data = await rootBundle.load("assets/regions.xlsx");
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        String code = row[0]?.value.toString() ?? '';
        int nx = int.parse(row[1]?.value.toString() ?? '0');
        int ny = int.parse(row[2]?.value.toString() ?? '0');

        if (code.isNotEmpty) {
          _regionMap[code] = RegionEntity(code: code, nx: nx, ny: ny);
        }
      }
    }
  }

  // 좌표 가져오기
  RegionEntity getRegion(AddressEntity addressEntity) {
    if (!_regionMap.containsKey(addressEntity.code)) {
      return _regionMap.values.first;
    }

    return _regionMap[addressEntity.code]!;
  }
}
