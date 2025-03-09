import 'package:excel/excel.dart';
import 'package:flutter/services.dart';

// 중기예보에서 사용하기위해 지역 이름으로 regId가져옴
class MiddleCodeDataSource {
  final Map<String, String> _middleRegionMap = {};

  MiddleCodeDataSource() {
    loadMiddleRegionData();
  }

  // 파일 불러와서 Map에 저장
  Future<void> loadMiddleRegionData() async {
    ByteData data = await rootBundle.load("assets/middle_region.xlsx");
    var bytes = data.buffer.asUint8List();
    var excel = Excel.decodeBytes(bytes);

    for (var table in excel.tables.keys) {
      for (var row in excel.tables[table]!.rows) {
        String middleRegion = row[0]?.value.toString().substring(0, 2) ?? '';
        String middleRegionId = row[1]?.value.toString() ?? '';

        if (middleRegion.isNotEmpty) {
          _middleRegionMap[middleRegion] = middleRegionId;
        }
      }
    }
  }

  // regId 가져오기
  String getMiddleRegionId(String middleRegion) {
    middleRegion = middleRegion.substring(0, 2);
    if (!_middleRegionMap.containsKey(middleRegion)) {
      return _middleRegionMap.values.first;
    }
    return _middleRegionMap[middleRegion]!;
  }
}
