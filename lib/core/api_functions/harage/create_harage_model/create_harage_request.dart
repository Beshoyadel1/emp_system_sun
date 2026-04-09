class CreateHarageRequest {
  final int provId;
  final int price;
  final String description;
  final int branchId;

  CreateHarageRequest({
    required this.provId,
    required this.price,
    required this.description,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "PRICE": price,
      "DESCRIPTION": description,
      "BRANCHID": branchId,
    };
  }
}