class UpdateCompanyDriverRequest {
  final int userId;
  final String userName;

  UpdateCompanyDriverRequest({
    required this.userId,
    required this.userName,
  });

  Map<String, dynamic> toJson() {
    return {
      "USERID": userId,
      "USERNAME": userName,
    };
  }
}