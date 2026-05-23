import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/order_model.dart';

class GetProviderOrdersResponse {
  final List<OrderModel> data;
  final int pageCount;
  final int totalCount;
  final int currentPage;

  GetProviderOrdersResponse({
    required this.data,
    required this.pageCount,
    required this.totalCount,
    required this.currentPage,
  });

  factory GetProviderOrdersResponse.fromJson(
      Map<String, dynamic> json) {

    final responseData = json['data'] ?? {};

    return GetProviderOrdersResponse(
      data: (responseData['data'] as List<dynamic>? ?? [])
          .map((e) => OrderModel.fromJson(e))
          .toList(),

      pageCount: responseData['pageCount'] ?? 0,

      totalCount: responseData['totalCount'] ?? 0,

      currentPage: responseData['currentPage'] ?? 1,
    );
  }
}