class GetAdminDashboardStatisticsRequest {
  final int userId;
  final int userType;
  final String startDate;
  final String endDate;

  GetAdminDashboardStatisticsRequest({
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
