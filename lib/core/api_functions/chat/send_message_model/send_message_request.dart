class SendMessageRequest {
  final int formUserId;
  final int formUserType;
  final String touserId;
  final int touserType;
  final String message;


  SendMessageRequest({
    required this.formUserId,
    required this.formUserType,
    required this.touserId,
    required this.touserType,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      "FROMUSERID": formUserId,
      "FROMUSERTYPE": formUserType,
      "TOUSERID": touserId,
      "TOUSERTYPE": touserType,
      "MESSAGE": message,
    };
  }
}
