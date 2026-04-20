class GetProviderOrdersSalesRequest {
  final int providerId;

  GetProviderOrdersSalesRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}