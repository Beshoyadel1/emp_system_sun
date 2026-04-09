class CreateCarBrandRequest {
  final int brandName;
  final String brandLatinName;

  CreateCarBrandRequest({
    required this.brandName,
    required this.brandLatinName,
  });

  Map<String, dynamic> toJson() {
    return {
      "BRANDNAME": brandName,
      "BRANDLATINNAME": brandLatinName,
    };
  }
}
