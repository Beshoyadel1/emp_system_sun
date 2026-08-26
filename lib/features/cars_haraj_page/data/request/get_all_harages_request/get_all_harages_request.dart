class GetAllHaragesRequest {
  final int pageNumber;

  GetAllHaragesRequest({
    required this.pageNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
    };
  }
}