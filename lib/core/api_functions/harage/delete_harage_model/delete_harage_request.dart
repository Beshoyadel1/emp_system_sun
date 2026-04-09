class DeleteHarageRequest {
  final int harageId;
  final int providerId;

  DeleteHarageRequest({
    required this.harageId,
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "harageId": harageId,
      "providerId": providerId,
    };
  }
}