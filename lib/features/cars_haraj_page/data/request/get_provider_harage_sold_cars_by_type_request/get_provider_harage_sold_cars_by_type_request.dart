class GetProviderHarageSoldCarsByTypeRequest {
  final int providerId;
  final int branchId;

  GetProviderHarageSoldCarsByTypeRequest({
    required this.providerId,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "branchId": branchId,
    };
  }
}