class GetStaticsForCouponRequest {
  final int couponId;

  GetStaticsForCouponRequest({
    required this.couponId,
  });

  Map<String, dynamic> toJson() {
    return {
      "couponId": couponId,
    };
  }
}
