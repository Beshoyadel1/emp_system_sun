class GetProviderPetrolSalesChartRequest {
  final int? providerId;
  final String? startDate;
  final String? endDate;
  final int? branchId;

  GetProviderPetrolSalesChartRequest({
     this.providerId,
     this.startDate,
     this.endDate,
     this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId??0,
      "startDate": startDate??"",
      "endDate": endDate??"",
      "branchId": branchId??0,
    };
  }
}