import '../../../../core/api_functions/statistics/get_provider_main_service_statistics_model/data_points_request.dart';

class SalesChartRequest {
  final List<DataPointsRequest> dataPoints;

  SalesChartRequest({
    required this.dataPoints,
  });

  factory SalesChartRequest.fromJson(Map<String, dynamic> json) {
    return SalesChartRequest(
      dataPoints: (json["dataPoints"] as List? ?? [])
          .map((e) => DataPointsRequest.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dataPoints": dataPoints.map((e) => e.toJson()).toList(),
    };
  }
}
