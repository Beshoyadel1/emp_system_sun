class UpdateOrderOfferStatusRequest {
  final int orderId;
  final int status;

  UpdateOrderOfferStatusRequest({
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