class GetCarBrandModelsRequest {
  final int carBrandId;

  GetCarBrandModelsRequest({
    required this.carBrandId,
  });

  Map<String, dynamic> toJson() {
    return {
      "carBrandId": carBrandId,
    };
  }
}
