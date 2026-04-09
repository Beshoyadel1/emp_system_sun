class UploadCouponRequest {
  final String code;
  final int discount;
  final String expireDate;

  UploadCouponRequest({
    required this.code,
    required this.discount,
    required this.expireDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "CODE": code,
      "DISCOUNT": discount,
      "EXPIRYDATE": expireDate,
    };
  }
}