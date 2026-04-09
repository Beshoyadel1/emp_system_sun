class GetProviderBranchesRequest {
  final int productId;

  GetProviderBranchesRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }
}