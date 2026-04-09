class RemoveCardRequest {
  final int paymentCardId;

  RemoveCardRequest({
    required this.paymentCardId,
  });

  Map<String, dynamic> toJson() {
    return {
      "paymentCARDId": paymentCardId,
    };
  }
}