class UpdateProductRequest {
  final int id;
  final String name;

  UpdateProductRequest({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "NAME": name,
    };
  }
}