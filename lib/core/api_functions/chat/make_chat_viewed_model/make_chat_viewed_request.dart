class MakeChatViewedRequest {
  final int chatId;

  MakeChatViewedRequest({
    required this.chatId,
  });

  Map<String, dynamic> toJson() {
    return {
      "chatId": chatId,
    };
  }
}