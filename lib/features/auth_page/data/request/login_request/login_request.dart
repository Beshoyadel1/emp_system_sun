class LoginRequest {
  final String user;
  final String password;
  final int type;
  final String? fcmToken;

  LoginRequest({
    required this.user,
    required this.password,
    required this.type,
    this.fcmToken,
  });

  Map<String, dynamic> toJson() {
    final cleanToken = fcmToken?.trim();
    return {
      "USER": user,
      "PASSWORD": password,
      "type": type,
      if (cleanToken != null && cleanToken.isNotEmpty) ...{
        "fcmtoken": cleanToken,
        "fcmToken": cleanToken,
        "FCMTOKEN": cleanToken,
      },
    };
  }
}
