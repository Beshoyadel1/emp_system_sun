class HarageStatusModel {
  final int? id;
  final int? harageId;
  final int? status;
  final String? date;
  final String? notes;

  HarageStatusModel({
    this.id,
    this.harageId,
    this.status,
    this.date,
    this.notes,
  });

  factory HarageStatusModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return HarageStatusModel(
      id: json['id'],
      harageId: json['harageid'],
      status: json['status'],
      date: json['date']?.toString(),
      notes: json['notes']?.toString(),
    );
  }
}