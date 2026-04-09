class GetProviderPetrolBranchesSalesRequest {
  final int providerId;
  final String startDate;
  final String endDate;

  GetProviderPetrolBranchesSalesRequest({
    required this.providerId,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId,
      "startDate": startDate,
      "endDate": endDate,
    };
  }
}