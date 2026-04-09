class GetHarageRequest {
  final int harageId;

  GetHarageRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      "harageId": harageId,
    };
  }
}