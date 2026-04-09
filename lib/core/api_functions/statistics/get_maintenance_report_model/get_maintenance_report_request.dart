class GetMaintenanceReportRequest {
  final int userId;
  final int userType;
  final String startDate;
  final String endDate;

  GetMaintenanceReportRequest({
    required this.userId,
    required this.userType,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}
