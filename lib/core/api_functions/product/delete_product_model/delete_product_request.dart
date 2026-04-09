class DeleteProductRequest {
  final int productId;

  DeleteProductRequest({
    required this.productId,
  });

  Map<String, dynamic> toJson() {
    return {
      "productId": productId,
    };
  }
}