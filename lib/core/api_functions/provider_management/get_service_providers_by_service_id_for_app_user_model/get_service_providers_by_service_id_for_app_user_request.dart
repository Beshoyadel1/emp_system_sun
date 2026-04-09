class GetServiceProvidersByServiceIdForAppUserRequest {
  final int serviceId;

  GetServiceProvidersByServiceIdForAppUserRequest({
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceId": serviceId,
    };
  }
}