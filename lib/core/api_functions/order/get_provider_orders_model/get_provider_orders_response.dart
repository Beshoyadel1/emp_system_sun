import '../../../../../core/api_functions/order/get_provider_orders_model/order_model.dart';

class GetProviderOrdersResponse {
  final List<OrderModel>? data;
  final int? pageCount;
  final int? totalCount;
  final int? currentPage;

  GetProviderOrdersResponse({
     this.data,
     this.pageCount,
     this.totalCount,
     this.currentPage,
  }
  );

  factory GetProviderOrdersResponse.fromJson(Map<String, dynamic> json) {
    return GetProviderOrdersResponse(
      data: (json['data'] as List)
          .map((e) => OrderModel.fromJson(e))
          .toList(),
      pageCount: json['pageCount'],
      totalCount: json['totalCount'],
      currentPage: json['currentPage'],
    );
  }
}