class AddCardRequest {
  final int userId;
  final int userType;
  final String cardName;
  final String cardNumber;
  final bool isDefault;


  AddCardRequest({
    required this.userId,
    required this.userType,
    required this.cardName,
    required this.cardNumber,
    required this.isDefault,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "USERTYPE": userType,
      "CARDNAME": cardName,
      "CARDNUMBER": cardNumber,
      "ISDEFAULT": isDefault,
    };
  }
}
