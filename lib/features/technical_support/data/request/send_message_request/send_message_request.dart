class SendMessageRequest {
  final int fromuser;
  final int touser;
  final int fromusertype;
  final int tousertype;
  final String message;
  final bool viewed;
  final int harageid;
  final int orderid;

  SendMessageRequest({
    int? fromuser,
    int? touser,
    int? fromusertype,
    int? tousertype,
    String? message,
    bool? viewed,
    int? harageid,
    int? orderid,
  })  : fromuser = fromuser ?? 0,
        touser = touser ?? 0,
        fromusertype = fromusertype ?? 0,
        tousertype = tousertype ?? 0,
        message = message ?? '',
        viewed = viewed ?? false,
        harageid = harageid ?? 0,
        orderid = orderid ?? 0;

  Map<String, dynamic> toJson() {
    return {
      "FROMUSER": fromuser,
      "TOUSER": touser,
      "FROMUSERTYPE": fromusertype,
      "TOUSERTYPE": tousertype,
      "MESSAGE": message,
      "VIEWED": viewed,
      "HARAGEID": harageid,
      "ORDERID": orderid,
    };
  }
}
