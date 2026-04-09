class GetAdminMostRequestedServicesRequest {
  final String startDate;
  final String endDate;

  GetAdminMostRequestedServicesRequest({
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
