class GetProvServicesRequest {
  final int providerId;
  final int serviceId;

  GetProvServicesRequest({
    required this.providerId,
    required this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "serviceId": serviceId,
    };
  }
}

