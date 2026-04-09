class GetAppUserInfoRequest {
  final String phone;

  GetAppUserInfoRequest({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
    };
  }
}