class GetProviderHarageSalesChartRequest {
  final int? providerId;
  final String? startDate;
  final String? endDate;
  final int? branchId;

  GetProviderHarageSalesChartRequest({
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