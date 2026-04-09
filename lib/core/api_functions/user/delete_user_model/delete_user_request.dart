class DeleteUserRequest {
  final int userId;
  final int type;

  DeleteUserRequest({
    required this.userId,
    required this.type,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "TYPE": type,
    };
  }
}
