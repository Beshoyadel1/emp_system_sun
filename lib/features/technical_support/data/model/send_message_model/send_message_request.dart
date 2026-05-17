class SendMessageRequest {
  final int? fromuser;
  final int? touser;
  final int? fromusertype;
  final int? tousertype;
  final String? message;
  final String? date;


  SendMessageRequest({
     this.fromuser,
     this.touser,
     this.fromusertype,
     this.tousertype,
     this.message,
     this.date,
  });

  Map<String, dynamic> toJson() {
    return {
      "fromuser": fromuser,
      "touser": touser,
      "fromusertype": fromusertype,
      "tousertype": tousertype,
      "message": message,
      "date": date,
    };
  }
}