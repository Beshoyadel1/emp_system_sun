class OpenCloseChatRequest {
  final int orderId;
  final bool status;

  OpenCloseChatRequest({
    required this.orderId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
      "status": status,
    };
  }
}