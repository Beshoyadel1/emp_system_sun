class GetUserProviderMessagesRequest {
  final int fromUserId;
  final int fromUserType;
  final int toUserId;
  final int toUserType;

  GetUserProviderMessagesRequest({
    required this.fromUserId,
    required this.fromUserType,
    required this.toUserId,
    required this.toUserType,

  });

  Map<String, dynamic> toJson() {
    return {
      "fromUserId": fromUserId,
      "fromUserType": fromUserType,
      "toUserId": toUserId,
      "companyId": toUserType,
    };
  }
}