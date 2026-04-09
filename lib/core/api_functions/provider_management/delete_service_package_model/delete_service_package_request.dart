class DeleteServicePackageRequest {
  final int servicePackageId;

  DeleteServicePackageRequest({
    required this.servicePackageId,
  });

  Map<String, dynamic> toJson() {
    return {
      "servicePackageId": servicePackageId,
    };
  }
}

