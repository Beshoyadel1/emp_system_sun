class GetProviderServiceStatisticsRequest {
  final int? providerId;

  GetProviderServiceStatisticsRequest({
     this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId??0,
    };
  }
}