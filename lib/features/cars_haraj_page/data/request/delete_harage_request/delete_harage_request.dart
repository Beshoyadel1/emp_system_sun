class DeleteHarageRequest {
  final int harageId;

  DeleteHarageRequest({
    required this.harageId,
  });

  Map<String, dynamic> toJson() {
    return {
      "harageId": harageId,
    };
  }
}