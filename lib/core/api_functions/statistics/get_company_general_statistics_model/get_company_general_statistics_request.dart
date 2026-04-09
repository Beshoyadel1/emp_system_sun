class GetCompanyGeneralStatisticsRequest {
  final int companyId;

  GetCompanyGeneralStatisticsRequest({
    required this.companyId,
  });

  Map<String, dynamic> toJson() {
    return {
      "companyId": companyId,
    };
  }
}
