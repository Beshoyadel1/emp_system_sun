class GetProviderBranchesRequest {
  final int providerId;

  GetProviderBranchesRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
    };
  }
}