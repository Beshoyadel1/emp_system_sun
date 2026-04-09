class RestoreUserRequest {
  final String phone;

  RestoreUserRequest({
    required this.phone,
  });

  Map<String, dynamic> toJson() {
    return {
      "phone": phone,
    };
  }
}
