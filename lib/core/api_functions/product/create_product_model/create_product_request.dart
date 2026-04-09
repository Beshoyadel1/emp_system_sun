class CreateProductRequest {
  final int provId;
  final String name;
  final int price;

  CreateProductRequest({
    required this.provId,
    required this.name,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "NAME": name,
      "PRICE": price,
    };
  }
}