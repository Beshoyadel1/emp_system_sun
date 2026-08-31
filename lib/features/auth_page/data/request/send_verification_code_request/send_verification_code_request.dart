class SendVerificationCodeRequest {
  final String user;
  final String message;

  SendVerificationCodeRequest({
    required this.user,
    required this.message,
  });

  Map<String, dynamic> toJson() {
    return {
      'user': user,
      'message': message,
    };
  }
}