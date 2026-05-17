import 'harag_data_points_model.dart';

class GetProviderHarageDataPointsResponse {
  final List<HaragDataPointsModel> dataPoints;

  GetProviderHarageDataPointsResponse({
    required this.dataPoints,
  });

  factory GetProviderHarageDataPointsResponse.fromJson(
      Map<String, dynamic> json) {
    return GetProviderHarageDataPointsResponse(
      dataPoints: (json['dataPoints'] as List? ?? [])
          .map((e) => HaragDataPointsModel.fromJson(e))
          .toList(),
    );
  }
}
