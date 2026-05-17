class DataPointsRequest {
  final String? label;
  final int? value;

  DataPointsRequest({
    this.label,
    this.value,
  });
  factory DataPointsRequest.fromJson(Map<String, dynamic> json) {
    return DataPointsRequest(
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