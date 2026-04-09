class UploadPointInfoRequest {
  final int pointsRate;
  final int pointsFrom;
  final int pointsTo;
  final int pointsCashBack;

  UploadPointInfoRequest({
    required this.pointsRate,
    required this.pointsFrom,
    required this.pointsTo,
    required this.pointsCashBack,
  });

  Map<String, dynamic> toJson() {
    return {
      "POINTSRATE": pointsRate,
      "POINTSFROM": pointsFrom,
      "POINTSTO": pointsTo,
      "POINTSCASHBACK": pointsCashBack,
    };
  }
}