// 중기예보 엔티티
class MiddleForecastEntity {
  double? taMin4;
  double? taMax4;
  final List<double> taMin;
  final List<double> taMax;

  MiddleForecastEntity({
    this.taMin4,
    this.taMax4,
    required this.taMin,
    required this.taMax,
  });

  factory MiddleForecastEntity.fromJson(Map<String, dynamic> json) {
    final items = (json["response"]["body"]["items"]["item"] as List).first;

    double? parseDouble(dynamic value) =>
        double.tryParse(value?.toString() ?? '');

    return MiddleForecastEntity(
      taMin4: parseDouble(items["taMin4"]),
      taMax4: parseDouble(items["taMax4"]),
      taMin: List.generate(5, (i) => parseDouble(items["taMin${i + 5}"]) ?? -1),
      taMax: List.generate(5, (i) => parseDouble(items["taMax${i + 5}"]) ?? -1),
    );
  }

  static MiddleForecastEntity emptyEntity() => MiddleForecastEntity(
        taMin: List.generate(5, (i) => 0),
        taMax: List.generate(5, (i) => 0),
      );

  void setTa4(double taMin4, double taMax4) {
    this.taMin4 = taMin4;
    this.taMax4 = taMax4;
  }
}
