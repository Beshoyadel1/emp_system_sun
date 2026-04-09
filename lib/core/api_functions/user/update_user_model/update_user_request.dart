class UpdateUserRequest {
  final int userId;
  final String userName;
  final int type;

  UpdateUserRequest({
    required this.userId,
    required this.userName,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "TYPE": type,
    };
  }
}
