class GetProviderServicePackagesRequest {
  final int providerId;

  GetProviderServicePackagesRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}