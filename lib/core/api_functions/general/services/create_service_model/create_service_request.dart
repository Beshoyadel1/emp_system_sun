class CreateServiceRequest {
  final int parentId;
  final String name;
  final String latinName;
  final String image;


  CreateServiceRequest({
    required this.parentId,
    required this.name,
    required this.latinName,
    required this.image,
  });

  Map<String, dynamic> toJson() {
    return {
      "PARENTID": parentId,
      "NAME": name,
      "LATINNAME": latinName,
      "IMAGE": image,

    };
  }
}