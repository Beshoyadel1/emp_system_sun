import '../../../../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_data.dart';

class GetUserHaragesResponse {
  final bool? success;
  final GetUserHaragesData? data;

  GetUserHaragesResponse({
    this.success,
    this.data,
  });

  factory GetUserHaragesResponse.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetUserHaragesResponse(
      success: json['success'],
      data: json['data'] is Map<String, dynamic>
          ? GetUserHaragesData.fromJson(
        json['data'] as Map<String, dynamic>,
      )
          : null,
    );
  }
}

class GetUserHaragesData {
  final List<HarageData> data;
  final int? pageCount;
  final int? totalCount;
  final int? currentPage;

  GetUserHaragesData({
    this.data = const [],
    this.pageCount,
    this.totalCount,
    this.currentPage,
  });

  factory GetUserHaragesData.fromJson(
      Map<String, dynamic> json,
      ) {
    return GetUserHaragesData(
      data: json['data'] is List
          ? (json['data'] as List)
          .whereType<Map<String, dynamic>>()
          .map(
            (e) => HarageData.fromJson(e),
      )
          .toList()
          : [],
      pageCount: json['pageCount'],
      totalCount: json['totalCount'],
      currentPage: json['currentPage'],
    );
  }
}