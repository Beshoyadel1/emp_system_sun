import 'package:emp_system_sun/features/cars_haraj_page/data/model/get_provider_harage_monthly_sales_model/harag_monthly_sale_model.dart';

class GetProviderHarageMonthlySalesResponse {
  final List<HaragMonthlySaleModel> monthlySales;

  GetProviderHarageMonthlySalesResponse({
    required this.monthlySales,
  });

  factory GetProviderHarageMonthlySalesResponse.fromJson(
      Map<String, dynamic> json) {
    return GetProviderHarageMonthlySalesResponse(
      monthlySales: (json['monthlySales'] as List? ?? [])
          .map((e) => HaragMonthlySaleModel.fromJson(e))
          .toList(),
    );
  }
}
