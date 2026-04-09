class GetUserCardsRequest {
  final int userId;
  final int userType;

  GetUserCardsRequest({
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