class ChangeHarageStatusRequest {
  final int harageId;
  final int status;
  final String? notes;

  ChangeHarageStatusRequest({
    required this.harageId,
    required this.status,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'harageid': harageId,
      'status': status,
      'notes': notes,
    };
  }
}