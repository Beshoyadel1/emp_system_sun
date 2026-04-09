class CarModelCreateServicePackageRequest {
  final int carBrandId;
  final List<int> carModelIds;

  CarModelCreateServicePackageRequest({
    required this.carBrandId,
    required this.carModelIds,
  });

  Map<String, dynamic> toJson() {
    return {
      "carbrandid": carBrandId,
      "carmodeliDs": carModelIds,
    };
  }
}