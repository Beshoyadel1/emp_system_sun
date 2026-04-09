class DeleteProvServiceRequest {
  final int provServiceId;

  DeleteProvServiceRequest({
    required this.provServiceId,
  });

  Map<String, dynamic> toJson() {
    return {
      "provServiceId": provServiceId,
    };
  }
}