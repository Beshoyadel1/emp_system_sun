import '../../../../core/api_functions/harage/get_all_harage_model/harage_data.dart';
class GetAllHarageResponse {
  final List<HarageData>? data;
  final int? pageCount;
  final int? totalCount;
  final int? currentPage;

  GetAllHarageResponse({
     this.data,
     this.pageCount,
     this.totalCount,
     this.currentPage,
  });

  factory GetAllHarageResponse.fromJson(Map<String, dynamic> json) {
    return GetAllHarageResponse(
      data: (json['data'] as List)
          .map((e) => HarageData.fromJson(e))
          .toList(),
      pageCount: json['pageCount'],
      totalCount: json['totalCount'],
      currentPage: json['currentPage'],
    );
  }
}