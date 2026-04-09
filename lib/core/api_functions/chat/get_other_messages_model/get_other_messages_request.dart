class GetOtherMessagesRequest {
  final int userId;
  final int userType;

  GetOtherMessagesRequest({
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