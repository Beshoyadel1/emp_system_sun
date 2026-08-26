class GetCarDetailsRequest {
  final int carId;

  GetCarDetailsRequest({
    required this.carId,
  });

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
    };
  }
}