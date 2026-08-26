class GetHarageDetailsRequest {
  final int harageId;

  GetHarageDetailsRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'harageId': harageId,
    };
  }
}