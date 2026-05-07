class GetProductsByCategoryRequest {
  final int categoryId;

  GetProductsByCategoryRequest({
    required this.categoryId,
  });

  Map<String, dynamic> toJson() {
    return {
      "categoryId": categoryId,
    };
  }
}