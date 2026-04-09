class GetCompanyDriversRequest {
  final int companyId;

  GetCompanyDriversRequest({
    required this.companyId,

  });

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
    };
  }
}