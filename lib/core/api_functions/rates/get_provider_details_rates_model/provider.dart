class Provider {
  final int? id;
  final String? name;
  final String? latinName;
  final String? image;

  Provider({
    this.id,
    this.name,
    this.latinName,
    this.image,
  });

  factory Provider.fromJson(Map<String, dynamic> json) {
    return Provider(
      id: json['id'],
      name: json['name'] ?? '',
      latinName: json['latinname'] ?? '',
      image: json['image'],
    );
  }
}
