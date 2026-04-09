class ChangeCouponStatusRequest {
  final int couponId;
  final bool status;

  ChangeCouponStatusRequest({
    required this.couponId,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      "couponId": couponId,
      "status": status,
    };
  }
}
