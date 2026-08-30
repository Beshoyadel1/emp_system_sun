class GetHarageChatRequest {
  final int harageId;

  const GetHarageChatRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      'harageId': harageId,
    };
  }
}