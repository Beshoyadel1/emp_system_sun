class SetDefaultCardRequest {
  final int userId;
  final int userType;
  final int paymentCardId;

  SetDefaultCardRequest({
    required this.userId,
    required this.userType,
    required this.paymentCardId,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "paymentCARDId": paymentCardId,
    };
  }
}