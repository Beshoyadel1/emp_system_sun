class CreateOrderRequest {
  final int userId;
  final int userType;
  final String provid;
  final int serviceId;
  final int totalPrice;


  CreateOrderRequest({
    required this.userId,
    required this.userType,
    required this.provid,
    required this.serviceId,
    required this.totalPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "USERTYPE": userType,
      "PROVID": provid,
      "SERVICEID": serviceId,
      "TOTALPRICE": totalPrice,
    };
  }
}