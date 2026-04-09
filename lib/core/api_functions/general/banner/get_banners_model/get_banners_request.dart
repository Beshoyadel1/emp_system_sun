class GetBannersRequest {
  final bool isActive;

  GetBannersRequest({
    required this.isActive,
  });

  Map<String, dynamic> toJson() {
    return {
      "isActive": isActive,
    };
  }
}
