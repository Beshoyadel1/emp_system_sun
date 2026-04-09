class GetProviderDetailsRatesRequest {
  final int? providerId;
  final int? serviceId;

  GetProviderDetailsRatesRequest({
     this.providerId,
     this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId??4,
      "serviceId": serviceId,
    };
  }
}