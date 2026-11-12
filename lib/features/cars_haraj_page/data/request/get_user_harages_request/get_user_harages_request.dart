class GetUserHaragesRequest {
  final int userId;
  final int userType;
  final int pageNumber;
  final int? branchId;
  final int? pageSize;
  final bool? includeSuspended;
  GetUserHaragesRequest({
    required this.userId,
    required this.userType,
    required this.pageNumber,
    this.branchId,
    this.pageSize,
    this.includeSuspended,
  });

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "userType": userType,
      "pageNumber": pageNumber,
      if (branchId != null) "branchId": branchId,
      if (pageSize != null) "pageSize": pageSize,
      if (includeSuspended != null) "includeSuspended": includeSuspended,
    };
  }
}
