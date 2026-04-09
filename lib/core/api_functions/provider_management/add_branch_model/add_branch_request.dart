class AddBranchRequest {
  final int provId;
  final String branchName;

  AddBranchRequest({
    required this.provId,
    required this.branchName,
  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "BRANCHNAME": branchName,
    };
  }
}
