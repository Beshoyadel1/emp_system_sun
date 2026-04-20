class GetPackageRequest {
  final int packageID;

  GetPackageRequest({
    required this.packageID,
  });

  Map<String, dynamic> toJson() {
    return {
      "packageID": packageID,
    };
  }
}