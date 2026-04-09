import 'dart:convert';
import 'dart:typed_data';

class ServiceModel {
  final int? id;
  final int? parentId;
  final String? name;
  final String? latinName;
  final Uint8List? image;
  //image: json["image"] != null ? base64Decode(json["image"]) : null,
//   "image": image != null ? base64Encode(image!) : null,
  ServiceModel({
    this.id,
    this.parentId,
    this.name,
    this.latinName,
    this.image,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    return ServiceModel(
      id: json['id'] ?? 0,
      parentId: json['parentid'] ?? 0,
      name: json['name'] ?? '',
      latinName: json['latinname'] ?? '',
      image: json["image"] != null ? base64Decode(json["image"]) : null,
    );
  }
}
