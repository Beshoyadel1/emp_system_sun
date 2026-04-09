class GetCarRequest {
  final int carId;

  GetCarRequest({
    required this.carId,
  });

  Map<String, dynamic> toJson() {
    return {
      "carId": carId,
    };
  }
}
