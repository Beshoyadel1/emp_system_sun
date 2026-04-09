class GetServicesRequest {
  final int providerId;

  GetServicesRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProviderId": providerId,
    };
  }
}