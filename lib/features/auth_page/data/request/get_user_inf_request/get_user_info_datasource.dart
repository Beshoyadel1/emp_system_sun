class GetUserInfoRequest {
  final int userId;
  final int userType;

  const GetUserInfoRequest({
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