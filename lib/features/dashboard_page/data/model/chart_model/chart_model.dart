class ChartModel {
  final DateTime date;
  final double value;

  ChartModel(this.date, this.value);
}

List<ChartModel> get sampleData {
  final now = DateTime.now();
  final startDate = DateTime(now.year, 5, 1);
  List<ChartModel> data = [];
  for (int i = 0; i < 75; i++) {
    final date = startDate.add(Duration(days: i * 4));

    double baseValue = 25000.0 + (i * 50.0);
    double fluctuation = (i % 7 < 3) ? (i * 200.0) : -(i * 100.0);
    double value = baseValue + fluctuation * (i * 0.1);
    if (date.month == 9 && date.day >= 20 && date.day <= 24) {
      value = 35000.0;
    } else if (i == 20) {
      value = 40000.0;
    } else if (i > 45 && i < 55) {
      value = 15000.0;
    } else if (i > 55 && i < 65) {
      value = 25000.0;
    }
    value = value.clamp(10000.0, 45000.0);
    data.add(ChartModel(date, value));
  }
  return data;
}
