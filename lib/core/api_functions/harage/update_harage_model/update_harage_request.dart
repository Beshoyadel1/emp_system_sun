class UpdateHarageRequest {
  final int id;
  final int provid;
  final int price;

  UpdateHarageRequest({
    required this.id,
    required this.provid,
    required this.price,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "PROVID": provid,
      "PRICE": price,
    };
  }
}