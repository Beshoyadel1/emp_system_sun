class GetProviderOrdersRequest {
  final int? providerId;
  final int? employeeId;
  final int? pageNumber;
  final int? orderType;
  final int? serviceId;
  final int? branchId;

  GetProviderOrdersRequest({
     this.providerId,
     this.employeeId,
     this.pageNumber,
     this.orderType,
     this.serviceId,
    this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "employeeId": employeeId,
      "pageNumber": pageNumber,
      "orderType": orderType,
      "ServiceId": serviceId,
      "branchId":branchId,
    };
  }
}