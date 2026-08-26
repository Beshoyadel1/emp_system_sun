class SendMessageRequest {
  final int? id;
  final int? fromuser;
  final int? touser;
  final int? fromusertype;
  final int? tousertype;
  final String? message;
  final String? date;
  final bool? viewed;
  final bool? isclosed;
  final int? harageid;
  final int? orderid;

  SendMessageRequest({
    this.id,
    this.fromuser,
    this.touser,
    this.fromusertype,
    this.tousertype,
    this.message,
    this.date,
    this.viewed,
    this.isclosed,
    this.harageid,
    this.orderid,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "FROMUSER": fromuser,
      "TOUSER": touser,
      "FROMUSERTYPE": fromusertype,
      "TOUSERTYPE": tousertype,
      "MESSAGE": message,
      "DATE": date,
      "VIEWED": viewed,
      "ISCLOSED": isclosed,
      "HARAGEID": harageid,
      "ORDERID": orderid,
    };
  }
}