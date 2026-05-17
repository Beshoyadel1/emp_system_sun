class GetProviderOrdersSalesModel {
  final List<DataPoint> dataPoints;

  GetProviderOrdersSalesModel({required this.dataPoints});

  factory GetProviderOrdersSalesModel.fromJson(Map<String, dynamic> json) {
    return GetProviderOrdersSalesModel(
      dataPoints: (json['dataPoints'] as List)
          .map((e) => DataPoint.fromJson(e))
          .toList(),
    );
  }
}

class DataPoint {
  final String? label;
  final double? value;

  DataPoint({this.label, this.value});

  factory DataPoint.fromJson(Map<String, dynamic> json) {
    return DataPoint(
      label: json['label'],
      value: (json['value'] ?? 0).toDouble(),
    );
  }

  DateTime get date {
    try {
      final parts = label!.split(" ");
      final day = int.parse(parts[0]);
      final month = _getMonth(parts[1]);

      return DateTime(DateTime.now().year, month, day);
    } catch (e) {
      return DateTime.now();
    }
  }

  int _getMonth(String monthName) {
    const months = {
      "يناير": 1,
      "فبراير": 2,
      "مارس": 3,
      "أبريل": 4,
      "مايو": 5,
      "يونيو": 6,
      "يوليو": 7,
      "أغسطس": 8,
      "سبتمبر": 9,
      "أكتوبر": 10,
      "نوفمبر": 11,
      "ديسمبر": 12,
    };

    return months[monthName] ?? 1;
  }
}