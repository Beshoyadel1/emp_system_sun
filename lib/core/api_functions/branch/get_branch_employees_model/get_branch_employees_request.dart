class GetBranchEmployeesRequest {
  final int providerId;
  final int branchId;

  GetBranchEmployeesRequest({
    required this.providerId,
    required this.branchId,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "branchId": branchId,
    };
  }
}

