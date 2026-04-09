class GetProviderOrdersSalesRequest {
  final int providerId;
  final String startDate;
  final String endDate;
  final int branchId;

  GetProviderOrdersSalesRequest({
    required this.providerId,
    required this.startDate,
    required this.endDate,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "startDate": startDate,
      "endDate": endDate,
      "branchId": branchId,
    };
  }
}