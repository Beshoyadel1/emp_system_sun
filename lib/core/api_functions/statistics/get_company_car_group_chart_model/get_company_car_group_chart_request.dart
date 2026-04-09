class GetCompanyCarGroupChartRequest {
  final int companyId;

  GetCompanyCarGroupChartRequest({
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
    };
  }
}
