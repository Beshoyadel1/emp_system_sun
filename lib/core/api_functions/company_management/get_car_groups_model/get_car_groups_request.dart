class GetCarGroupsRequest {
  final int companyId;

  GetCarGroupsRequest({
    required this.companyId,

  });

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
    };
  }
}