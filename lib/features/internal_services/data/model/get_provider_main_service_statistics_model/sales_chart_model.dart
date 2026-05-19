
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_main_service_statistics_model/data_points_model.dart';

class SalesChartModel {
  final List<DataPointsModel> dataPoints;

  SalesChartModel({
    required this.dataPoints,
  });

  factory SalesChartModel.fromJson(Map<String, dynamic> json) {
    return SalesChartModel(
      dataPoints: (json["dataPoints"] as List? ?? [])
          .map((e) => DataPointsModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "dataPoints": dataPoints.map((e) => e.toJson()).toList(),
    };
  }
}
