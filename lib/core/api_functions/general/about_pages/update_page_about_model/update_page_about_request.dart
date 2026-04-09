class UpdatePageAboutRequest {
  final int id;
  final String contentText;

  UpdatePageAboutRequest({
    required this.id,
    required this.contentText,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "CONTENTTEXT": contentText,
    };
  }
}
