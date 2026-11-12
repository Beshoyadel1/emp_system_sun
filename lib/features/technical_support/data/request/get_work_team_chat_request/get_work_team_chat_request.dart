class GetWorkTeamChatRequest {
  final int user;
  final int userType;

  GetWorkTeamChatRequest({
    required this.user,
    required this.userType,

  });

  Map<String, dynamic> toJson() {
    return {
      "userId": user,
      "user": user,
      "userType": userType,
    };
  }
}