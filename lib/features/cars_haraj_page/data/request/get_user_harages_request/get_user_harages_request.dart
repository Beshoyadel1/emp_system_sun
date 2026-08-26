class GetUserHaragesRequest {
  final int userId;
  final int userType;
  final int pageNumber;
  GetUserHaragesRequest({
    required this.userId,
    required this.userType,
    required this.pageNumber,

  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "pageNumber": pageNumber,
    };
  }
}