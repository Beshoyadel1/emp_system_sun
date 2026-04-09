class CancelOrderRequest {
  final int orderId;

  CancelOrderRequest({
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
    };
  }
}