class GetUserNewNotificationRequest {
  final int userId;
  final int userType;
  final int? pageSize,pageNumber;
  GetUserNewNotificationRequest({
    required this.userId,
    required this.userType,
    this.pageNumber,
    this.pageSize
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "pageNumber": pageNumber,
      "pageSize": pageSize,
    };
  }
}