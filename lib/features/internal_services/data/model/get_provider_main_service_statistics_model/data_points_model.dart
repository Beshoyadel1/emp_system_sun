class DataPointsModel {
  final String? label;
  final int? value;

  DataPointsModel({
    this.label,
    this.value,
  });
  factory DataPointsModel.fromJson(Map<String, dynamic> json) {
    return DataPointsModel(
      label: json["label"],
      value: json["value"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "label": label??"",
      "value": value??0,
    };
  }
}