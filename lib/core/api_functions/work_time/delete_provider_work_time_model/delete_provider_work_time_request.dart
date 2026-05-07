class DeleteProviderWorkTimeRequest {
  final int providerId;
  final int workTimeId;

  DeleteProviderWorkTimeRequest({
    required this.providerId,
    required this.workTimeId,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProviderId": providerId,
      "workTimeId": workTimeId,
    };
  }
}

