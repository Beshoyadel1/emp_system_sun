class GetOrdersRequest {
  final int userId;
  final int userType;

  GetOrdersRequest({
    required this.userId,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
    };
  }
}