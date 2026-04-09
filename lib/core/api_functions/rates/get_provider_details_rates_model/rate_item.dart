class RateItem {
  final int? id;
  final int? orderId;
  final int? providerId;
  final int? userId;
  final int? userType;
  final int? serviceId;
  final String? username;
  final String? userImage;
  final String? message;
  final int? rate;

  RateItem({
    this.id,
    this.orderId,
    this.providerId,
    this.userId,
    this.userType,
    this.serviceId,
    this.username,
    this.userImage,
    this.message,
    this.rate,
  });

  factory RateItem.fromJson(Map<String, dynamic> json) {
    return RateItem(
      id: json['id'],
      orderId: json['orderid'],
      providerId: json['provid'],
      userId: json['userid'],
      userType: json['usertype'],
      serviceId: json['serviceid'],
      username: json['username'] ?? '',
      userImage: json['userimage'],
      message: json['message'] ?? '',
      rate: json['rate'] ?? 0,
    );
  }
}
