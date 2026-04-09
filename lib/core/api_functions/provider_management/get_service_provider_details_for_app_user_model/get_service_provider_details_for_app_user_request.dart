class GetServiceProviderDetailsForAppUserRequest {
  final int providerId;

  GetServiceProviderDetailsForAppUserRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}