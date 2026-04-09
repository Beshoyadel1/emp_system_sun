class GetProductsSuitableForCarRequest {
  final int carId;

  GetProductsSuitableForCarRequest({
    required this.carId,
  });

  Map<String, dynamic> toJson() {
    return {
      "carId": carId,
    };
  }
}