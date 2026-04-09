class UploadProviderWorkTimesRequest {
  final int provId;
  final bool sat;
  final String fromTime;
  final String toTime;

  UploadProviderWorkTimesRequest({
    required this.provId,
    required this.sat,
    required this.fromTime,
    required this.toTime,

  });

  Map<String, dynamic> toJson() {
    return {
      "PROVID": provId,
      "SAT": sat,
      "FROMTIME": fromTime,
      "TOTIME": toTime,

    };
  }
}
