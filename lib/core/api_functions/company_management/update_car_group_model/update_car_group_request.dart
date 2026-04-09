class UpdateCarGroupRequest {
  final int companyId;
  final String groupName;

  UpdateCarGroupRequest({
    required this.companyId,
    required this.groupName,
  });

  Map<String, dynamic> toJson() {
    return {
      "GROUPID": companyId,
      "GROUPNAME": groupName,
    };
  }
}