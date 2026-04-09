class GetCouponByCodeRequest {
  final int userId;
  final int userType;
  final String code;

  GetCouponByCodeRequest({
    required this.userId,
    required this.userType,
    required this.code,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "code": code,
    };
  }
}
