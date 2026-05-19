class GetProviderWorkTimeRequest {
  final int providerId;

  GetProviderWorkTimeRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProviderId": providerId,
    };
  }
}

