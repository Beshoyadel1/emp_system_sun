class UpdateCarBrandRequest {
  final String brandName;
  final int brandId;

  UpdateCarBrandRequest({
    required this.brandName,
    required this.brandId,
  });

  Map<String, dynamic> toJson() {
    return {
      "BRANDNAME": brandName,
      "BRANDID": brandId,
    };
  }
}
