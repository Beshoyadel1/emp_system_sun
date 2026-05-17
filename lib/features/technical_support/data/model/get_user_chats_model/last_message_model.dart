class LastMessageModel {
  final int? id;
  final int? fromUser;
  final int? toUser;
  final String? message;
  final DateTime? date;
  final bool? viewed;

  LastMessageModel({
    this.id,
    this.fromUser,
    this.toUser,
    this.message,
    this.date,
    this.viewed,
  });

  factory LastMessageModel.fromJson(Map<String, dynamic> json) {
    return LastMessageModel(
      id: json['id'] ?? 0,
      fromUser: json['fromuser'] ?? 0,
      toUser: json['touser'] ?? 0,
      message: json['message'] ?? "",
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      viewed: json['viewed'] ?? false,
    );
  }
}
