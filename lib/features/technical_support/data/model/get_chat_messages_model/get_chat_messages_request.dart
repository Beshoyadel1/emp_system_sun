class GetChatMessagesRequest {
  final int fromUserId, fromUserType, toUserId, toUserType;

  GetChatMessagesRequest(
      {required this.fromUserId,
      required this.fromUserType,
      required this.toUserId,
      required this.toUserType});

  Map<String, dynamic> toJson() {
    return {
      "fromUserId": fromUserId,
      "fromUserType": fromUserType,
      "toUserId": toUserId,
      "toUserType": toUserType,
    };
  }
}
