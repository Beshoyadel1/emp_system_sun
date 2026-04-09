class GetProvidersBasicRateRequest {
  final int productId;

  GetProvidersBasicRateRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }
}