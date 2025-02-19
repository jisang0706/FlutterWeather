// 역지오코딩 주소 엔티티
class AddressEntity {
  final String addressName;
  final String region1Depth;
  final String region2Depth;
  final String region3Depth;
  final String code;

  AddressEntity(
      {required this.addressName,
      required this.region1Depth,
      required this.region2Depth,
      required this.region3Depth,
      required this.code});

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    final address =
        json["documents"].where((doc) => doc["region_type"] == "H").first;
    return AddressEntity(
        addressName: address["address_name"],
        region1Depth: address["region_1depth_name"],
        region2Depth: address["region_2depth_name"],
        region3Depth: address["region_3depth_name"],
        code: address["code"]);
  }

  factory AddressEntity.emptyEntity() {
    return AddressEntity(
        addressName: "",
        region1Depth: "",
        region2Depth: "",
        region3Depth: "",
        code: "1100000000");
  }
}
