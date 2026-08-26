import '../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';

class GetAllHarageResponse {
  final List<HarageData> data;
  final int pageCount;
  final int totalCount;
  final int currentPage;

  GetAllHarageResponse({
    required this.data,
    required this.pageCount,
    required this.totalCount,
    required this.currentPage,
  });

  factory GetAllHarageResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetAllHarageResponse(
      data: json['data'] is List
          ? (json['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map(
            (e) => HarageData.fromJson(e),
      )
          .toList()
          : [],

      pageCount:
      (json['pageCount'] ?? 0) is num
          ? (json['pageCount'] ?? 0).toInt()
          : 0,

      totalCount:
      (json['totalCount'] ?? 0) is num
          ? (json['totalCount'] ?? 0).toInt()
          : 0,

      currentPage:
      (json['currentPage'] ?? 1) is num
          ? (json['currentPage'] ?? 1).toInt()
          : 1,
    );
  }
}