class GetAvailableTaxesRequest {
  final int harageId;

  GetAvailableTaxesRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      "harageId": harageId,
    };
  }
}