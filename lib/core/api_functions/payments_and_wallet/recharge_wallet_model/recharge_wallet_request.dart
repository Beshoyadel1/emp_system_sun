class RechargeWalletRequest {
  final int userId;
  final int userType;
  final int totalPrice;

  RechargeWalletRequest({
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
