class GetProviderTotalRateAndEmployeeAndBalanceRequest {
  final int providerId;

  GetProviderTotalRateAndEmployeeAndBalanceRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}