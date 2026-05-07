class UpdateBranchRequest {
  final int provId;
  final int branchId;
  final String branchName;

  UpdateBranchRequest({
    required this.provId,
    required this.branchId,
    required this.branchName,
  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "BRANCHID": branchId,
      "BRANCHNAME": branchName,
    };
  }
}
