class GetPointInfoRequest {
  final int harageId;

  GetPointInfoRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      "harageId": harageId,
    };
  }
}