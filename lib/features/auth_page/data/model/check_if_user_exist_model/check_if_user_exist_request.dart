class CheckIfUserExistRequest {
  final String? email;
  final String? type;

  CheckIfUserExistRequest({
     this.email,
     this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "email": email??"",
      "type": type??4,
    };
  }
}
