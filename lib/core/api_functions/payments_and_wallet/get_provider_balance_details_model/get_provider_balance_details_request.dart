class GetProviderBalanceDetailsRequest {
  final int providerId;

  GetProviderBalanceDetailsRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}