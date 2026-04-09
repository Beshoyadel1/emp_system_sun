class GetAllPagesAboutRequest {
  final int providerId;

  GetAllPagesAboutRequest({
    required this.providerId,
  });

  Map<String, dynamic> toJson() {
    return {
      "ProviderId": providerId,
    };
  }
}