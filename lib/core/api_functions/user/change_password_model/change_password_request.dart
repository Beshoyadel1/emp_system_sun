class ChangePasswordRequest {
  final String? user;
  final String? password;
  final int? type;

  ChangePasswordRequest({
     this.user,
     this.password,
     this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "USER": user??"",
      "PASSWORD": password??"",
      "TYPE": type??4,
    };
  }
}
