class GetOrderDetailsRequest {
  final int orderId;

  GetOrderDetailsRequest({
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
    };
  }
}