class HaragDataPointsModel {
  final String label;
  final num value;

  HaragDataPointsModel({
    required this.label,
    required this.value,
  });

  factory HaragDataPointsModel.fromJson(Map<String, dynamic> json) {
    return HaragDataPointsModel(
      label: json['label'] ?? '',
      value: json['value'] ?? 0,
    );
  }
}