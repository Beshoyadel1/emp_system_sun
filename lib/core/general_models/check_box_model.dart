class CheckBoxModel {
  int? id;
  String? arName;
  String? enName;
  bool? value;

  CheckBoxModel({this.id, this.arName, this.enName, this.value});

  CheckBoxModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    arName = json['arName'];
    enName = json['enName'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['arName'] = this.arName;
    data['enName'] = this.enName;
    data['value'] = this.value;
    return data;
  }
}
