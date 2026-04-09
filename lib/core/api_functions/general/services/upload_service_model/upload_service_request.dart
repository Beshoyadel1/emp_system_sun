class UploadServiceRequest {
  final int id;
  final String name;


  UploadServiceRequest({
    required this.id,
    required this.name,
  });

  Map<String, dynamic> toJson() {
    return {
      "ID": id,
      "NAME": name,
    };
  }
}