class UpdateOrderStatusRequest {
  final int orderId;
  final int status;

  UpdateOrderStatusRequest({
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