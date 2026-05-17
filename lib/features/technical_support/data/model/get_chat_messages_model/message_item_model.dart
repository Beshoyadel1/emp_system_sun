class MessageItemModel {
  final int id;
  final int fromUser;
  final int toUser;
  final String message;
  final DateTime? date;
  final bool viewed;

  MessageItemModel({
    required this.id,
    required this.fromUser,
    required this.toUser,
    required this.message,
    this.date,
    required this.viewed,
  });

  factory MessageItemModel.fromJson(Map<String, dynamic> json) {
    return MessageItemModel(
      id: json['id'] ?? 0,
      fromUser: json['fromuser'] ?? 0,
      toUser: json['touser'] ?? 0,
      message: json['message'] ?? "",
      date: json['date'] != null
          ? DateTime.tryParse(json['date'])
          : null,
      viewed: json['viewed'] == true,
    );
  }
}