import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/sales_chart_model.dart';
import '../../model/get_provider_main_service_statistics_model/sub_service_summaries_model.dart';

class GetProviderMainServiceStatisticsRequest {
  final int? providerId;
  final int? mainServiceId;
  final String? startDate;
  final String? endDate;
  final int? branchId;
  final double? averageRate;
  final SubServiceSummariesModel? subServiceSummaries;
  final SalesChartModel? salesChart;

  GetProviderMainServiceStatisticsRequest(
      {
      this.providerId,
      this.mainServiceId,
      this.startDate,
      this.endDate,
      this.branchId,
      this.averageRate,
      this.subServiceSummaries,
      this.salesChart
      }
      );

  factory GetProviderMainServiceStatisticsRequest.fromJson(
      Map<String, dynamic> json) {
    return GetProviderMainServiceStatisticsRequest(
      providerId: json["providerId"],
      mainServiceId: json["mainServiceId"],
      startDate: json["startDate"],
      endDate: json["endDate"],
      branchId: json["branchId"],
      averageRate: json["averageRate"],
      subServiceSummaries: json["subServiceSummaries"] != null
          ? SubServiceSummariesModel.fromJson(json["subServiceSummaries"])
          : null,
      salesChart: json["salesChart"] != null
          ? SalesChartModel.fromJson(json["salesChart"])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "providerId": providerId ,
      "mainServiceId": mainServiceId,
      "startDate": startDate,
      "endDate": endDate,
      "branchId": branchId,
      "averageRate": averageRate,
      "subServiceSummaries": subServiceSummaries?.toJson(),
      "salesChart": salesChart?.toJson(),
    };
  }
}
