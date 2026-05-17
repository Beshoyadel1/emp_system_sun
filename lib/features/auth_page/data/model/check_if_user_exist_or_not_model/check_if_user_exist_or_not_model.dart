class CheckIfUserExistOrNotModel {
  final int? id;
  final String? phone;
  final String? email;
  final bool? value;

  CheckIfUserExistOrNotModel({
    this.id,
    this.phone,
    this.email,
    this.value,
  });

  factory CheckIfUserExistOrNotModel.fromJson(Map<String, dynamic> json) {
    return CheckIfUserExistOrNotModel(
      id: json['id'],
      phone: json['phone'],
      email: json['email'],
      value: json['value'],
    );
  }
}