class GetCompanyOrdersRequest {
  final int companyId;

  GetCompanyOrdersRequest({
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
    };
  }
}