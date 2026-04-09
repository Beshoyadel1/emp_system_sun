class CreateCarModelRequest {
  final int modelName;
  final String carBrandId;

  CreateCarModelRequest({
    required this.modelName,
    required this.carBrandId,
  });

  Map<String, dynamic> toJson() {
    return {
      "MODELNAME": modelName,
      "CARBRANDID": carBrandId,
    };
  }
}
