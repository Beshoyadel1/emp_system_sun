class CreateRateRequest {
  final int provId;
  final int userId;
  final int rate;
  final String message;

  CreateRateRequest({
    required this.provId,
    required this.userId,
    required this.rate,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "USERID": userId,
      "RATE": rate,
      "MESSAGE": message,
    };
  }
}
