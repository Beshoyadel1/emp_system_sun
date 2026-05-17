class HaragMonthlySaleModel {
  final String label;
  final num value;

  HaragMonthlySaleModel({
    required this.label,
    required this.value,
  });

  factory HaragMonthlySaleModel.fromJson(Map<String, dynamic> json) {
    return HaragMonthlySaleModel(
      label: json['label'] ?? '',
      value: json['value'] ?? 0,
    );
  }
}