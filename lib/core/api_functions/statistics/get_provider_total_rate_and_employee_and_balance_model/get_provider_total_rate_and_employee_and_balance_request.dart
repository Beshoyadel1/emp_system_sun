class GetProviderTotalRateAndEmployeeAndBalanceRequest {
  final int providerId;
  final int branchId;

  GetProviderTotalRateAndEmployeeAndBalanceRequest({
    required this.providerId,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "branchId": branchId,
    };
  }
}