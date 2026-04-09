class LanguageModel {
  String? arName;
  String? enName;
  int? number;

  LanguageModel({this.arName, this.enName, this.number});

  LanguageModel.fromJson(Map<String, dynamic> json) {
    arName = json['arName'];
    enName = json['enName'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arName'] = arName;
    data['enName'] = enName;
    data['number'] = number;
    return data;
  }
}
