class GetProductRequest {
  final int productId;

  GetProductRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }
}