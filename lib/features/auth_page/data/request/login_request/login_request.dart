class LoginRequest {
  final String user;
  final String password;
  final int type;

  LoginRequest({
    required this.user,
    required this.password,
    required this.type
  });

  Map<String, dynamic> toJson() {
    return {
      "USER": user,
      "PASSWORD": password,
      "type":type
    };
  }
}
