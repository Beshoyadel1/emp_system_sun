class GetWorkTeamChatRequest {
  final int workTeamId;

  GetWorkTeamChatRequest({
    required this.workTeamId,
  });

  Map<String, dynamic> toJson() {
    return {
      "workTeamId": workTeamId,
    };
  }
}