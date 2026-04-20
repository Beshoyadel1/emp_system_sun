class CheckIfUserExistOrNotRequest {
  final String user;
  final int type;

  CheckIfUserExistOrNotRequest({
    required this.user,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "user": user,
      "type": type,
    };
  }
}
