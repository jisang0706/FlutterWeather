// 역지오코딩 주소 엔티티
class AddressEntity {
  final String addressName;
  final String region1Depth;
  final String region2Depth;
  final String region3Depth;

  AddressEntity(
      {required this.addressName,
      required this.region1Depth,
      required this.region2Depth,
      required this.region3Depth});

  factory AddressEntity.fromJson(Map<String, dynamic> json) {
    final address = json["documents"][0]["address"];
    return AddressEntity(
        addressName: address["address_name"],
        region1Depth: address["region_1depth_name"],
        region2Depth: address["region_2depth_name"],
        region3Depth: address["region_3depth_name"]);
  }
}
