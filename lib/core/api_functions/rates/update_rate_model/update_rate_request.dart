class UpdateRateRequest {
  final int id;
  final int rate;

  UpdateRateRequest({
    required this.id,
    required this.rate,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "RATE": rate,
    };
  }
}
