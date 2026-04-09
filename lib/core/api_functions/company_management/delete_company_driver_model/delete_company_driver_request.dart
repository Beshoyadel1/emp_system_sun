class DeleteCompanyDriverRequest {
  final int driverId;

  DeleteCompanyDriverRequest({
    required this.driverId,

  });

  Map<String, dynamic> toJson() {
    return {
      "driverId": driverId,
    };
  }
}