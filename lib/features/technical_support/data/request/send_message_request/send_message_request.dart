class SendMessageRequest {
  final int id;
  final int fromuser;
  final int touser;
  final int fromusertype;
  final int tousertype;
  final String message;
  final String date;
  final bool viewed;
  final bool isclosed;
  final int harageid;
  final int orderid;

  SendMessageRequest({
    int? id,
    int? fromuser,
    int? touser,
    int? fromusertype,
    int? tousertype,
    String? message,
    String? date,
    bool? viewed,
    bool? isclosed,
    int? harageid,
    int? orderid,
  })  : id = id ?? 0,
        fromuser = fromuser ?? 0,
        touser = touser ?? 0,
        fromusertype = fromusertype ?? 0,
        tousertype = tousertype ?? 0,
        message = message ?? '',
        date = date ?? '',
        viewed = viewed ?? true,
        isclosed = isclosed ?? true,
        harageid = harageid ?? 0,
        orderid = orderid ?? 0;

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