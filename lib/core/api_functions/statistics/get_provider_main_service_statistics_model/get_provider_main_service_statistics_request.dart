import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sales_chart_request.dart';
import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/sub_service_summaries_request.dart';

class GetProviderMainServiceStatisticsRequest {
  final int? providerId;
  final int? mainServiceId;
  final String? startDate;
  final String? endDate;
  final int? branchId;
  final double? averageRate;
  final SubServiceSummariesRequest? subServiceSummaries;
  final SalesChartRequest? salesChart;

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
          ? SubServiceSummariesRequest.fromJson(json["subServiceSummaries"])
          : null,
      salesChart: json["salesChart"] != null
          ? SalesChartRequest.fromJson(json["salesChart"])
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
