class GetUserChatsRequest {
  final int userId;
  final int userType;

  GetUserChatsRequest({
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