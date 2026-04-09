class GetProviderOrdersRequest {
  final int? providerId;
  final int? employeeId;
  final int? pageNumber;
  final int? orderType;
  final int? serviceId;

  GetProviderOrdersRequest({
     this.providerId,
     this.employeeId,
     this.pageNumber,
     this.orderType,
     this.serviceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "employeeId": employeeId,
      "pageNumber": pageNumber,
      "orderType": orderType,
      "ServiceId": serviceId,
    };
  }
}