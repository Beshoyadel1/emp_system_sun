class GetOrderDetailsDatasource {
  final int orderId;

  GetOrderDetailsDatasource({
    required this.orderId,
  });

  Map<String, dynamic> toJson() {
    return {
      "orderId": orderId,
    };
  }
}