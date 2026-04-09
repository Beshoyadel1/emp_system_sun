class DeleteRateRequest {
  final int rateId;

  DeleteRateRequest({
    required this.rateId,
  });

  Map<String, dynamic> toJson() {
    return {
      "rateId": rateId,
    };
  }
}