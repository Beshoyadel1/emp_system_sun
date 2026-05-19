class GetWorkTeamChatRequest {
  final int user;
  final int userType;

  GetWorkTeamChatRequest({
    required this.user,
    required this.userType,

  });

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "userType": userType,
    };
  }
}