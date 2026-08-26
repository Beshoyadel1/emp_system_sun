class GetProviderHarageSoldCarsByTypeModel {
  final int newCarsCount;
  final int usedCarsCount;

  GetProviderHarageSoldCarsByTypeModel({
    required this.newCarsCount,
    required this.usedCarsCount,
  });

  factory GetProviderHarageSoldCarsByTypeModel.fromJson(
      Map<String, dynamic> json) {

    final data = json['data'];

    return GetProviderHarageSoldCarsByTypeModel(
      newCarsCount: data['newCarsCount'] ?? 0,
      usedCarsCount: data['usedCarsCount'] ?? 0,
    );
  }
}