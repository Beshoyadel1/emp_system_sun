class PetrolChartPoint {
  final String label;
  final num value;

  PetrolChartPoint({
    required this.label,
    required this.value,
  });

  factory PetrolChartPoint.fromJson(Map<String, dynamic> json) {
    return PetrolChartPoint(
      label: json['label'],
      value: json['value'],
    );
  }
}
