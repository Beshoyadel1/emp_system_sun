class UploadBannersRequest {
  final String image;
  final String startDate;
  final String endDate;

  UploadBannersRequest({
    required this.image,
    required this.startDate,
    required this.endDate,
  });

  Map<String, dynamic> toJson() {
    return {
      "IMAGE": image,
      "STARTDATE": startDate,
      "ENDDATE": endDate,
    };
  }
}
