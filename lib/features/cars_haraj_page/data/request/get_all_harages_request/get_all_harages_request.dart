class GetAllHaragesRequest {
  final int pageNumber;
  final int? pageSize;
  final bool? isNew;
  final int? status;
  final bool? includeSuspended;
  final String? search;
  final num? minPrice;
  final num? maxPrice;

  GetAllHaragesRequest({
    required this.pageNumber,
    this.pageSize,
    this.isNew,
    this.status,
    this.includeSuspended,
    this.search,
    this.minPrice,
    this.maxPrice,
  });

  Map<String, dynamic> toJson() {
    return {
      'pageNumber': pageNumber,
      if (pageSize != null) 'pageSize': pageSize,
      if (isNew != null) 'isNew': isNew,
      if (status != null) 'status': status,
      if (includeSuspended != null) 'includeSuspended': includeSuspended,
      if (search?.trim().isNotEmpty == true) 'search': search!.trim(),
      if (minPrice != null) 'minPrice': minPrice,
      if (maxPrice != null) 'maxPrice': maxPrice,
    };
  }
}
