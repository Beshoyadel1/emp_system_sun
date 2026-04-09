class CreateCarGroupRequest {
  final int companyId;
  final String groupName;

  CreateCarGroupRequest({
    required this.companyId,
    required this.groupName,
  });

  Map<String, dynamic> toJson() {
    return {
      "COMPANYID": companyId,
      "GROUPNAME": groupName,
    };
  }
}