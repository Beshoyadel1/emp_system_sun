class GetAllHarageRequest {
  final int? pageNumber;

  GetAllHarageRequest({
    this.pageNumber = 1,
  });

  Map<String, dynamic> toJson() {
    return {
      "pageNumber": pageNumber,
    };
  }
}
