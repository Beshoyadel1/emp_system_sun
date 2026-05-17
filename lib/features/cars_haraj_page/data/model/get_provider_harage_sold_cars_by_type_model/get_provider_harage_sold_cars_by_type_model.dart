class GetProviderHarageSoldCarsByTypeModel {
  final int newCarsCount;
  final int usedCarsCount;

  GetProviderHarageSoldCarsByTypeModel({
    required this.newCarsCount,
    required this.usedCarsCount,
  });

  factory GetProviderHarageSoldCarsByTypeModel.fromJson(Map<String, dynamic> json) {
    return GetProviderHarageSoldCarsByTypeModel(
      newCarsCount: json['newCarsCount'] ?? 0,
      usedCarsCount: json['usedCarsCount'] ?? 0,
    );
  }
}