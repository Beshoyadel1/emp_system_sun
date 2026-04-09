class GetWalletTransactionsRequest {
  final int userId;
  final int userType;

  GetWalletTransactionsRequest({
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