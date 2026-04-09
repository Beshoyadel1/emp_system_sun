class CreatePaymentRequest {
  final int userId;
  final int userType;
  final int totalPrice;

  CreatePaymentRequest({
    required this.userId,
    required this.userType,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "USERTYPE": userType,
      "TOTALPRICE": totalPrice,
    };
  }
}
