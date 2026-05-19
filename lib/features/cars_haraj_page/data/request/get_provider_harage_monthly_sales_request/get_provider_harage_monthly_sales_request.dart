class GetProviderHarageMonthlySalesRequest {
  final int? providerId;
  final int? branchId;

  GetProviderHarageMonthlySalesRequest({
     this.providerId,
     this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId??0,
      "branchId": branchId??0,
    };
  }
}