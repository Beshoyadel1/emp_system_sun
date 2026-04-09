class UpdateCarModelRequest {
  final int modelId;
  final String modelName;

  UpdateCarModelRequest({
    required this.modelId,
    required this.modelName,
  });

  Map<String, dynamic> toJson() {
    return {
      "MODELID": modelId,
      "MODELNAME": modelName,
    };
  }
}