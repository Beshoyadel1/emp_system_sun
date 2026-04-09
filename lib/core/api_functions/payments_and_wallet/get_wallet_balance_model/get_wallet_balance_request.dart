class GetWalletBalanceRequest {
  final int userId;
  final int userType;

  GetWalletBalanceRequest({
    required this.userId,
    required this.userType,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
    };
  }
}