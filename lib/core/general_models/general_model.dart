class GeneralModel {
  String? arName;
  String? enName;
  int? number;

  GeneralModel({this.arName, this.enName, this.number});

  GeneralModel.fromJson(Map<String, dynamic> json) {
    arName = json['arName'];
    enName = json['enName'];
    number = json['number'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['arName'] = this.arName;
    data['enName'] = this.enName;
    data['number'] = this.number;
    return data;
  }
}
