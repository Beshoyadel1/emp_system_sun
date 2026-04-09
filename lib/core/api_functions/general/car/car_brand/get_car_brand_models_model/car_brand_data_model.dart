import 'dart:convert';
import 'dart:typed_data';

class CarBrandDataModel {
  final int? id;
  final String? name;
  final String? latinName;
  final Uint8List? image;

  CarBrandDataModel({
    this.id,
    this.name,
    this.latinName,
    this.image,
  });

  factory CarBrandDataModel.fromJson(Map<String, dynamic> json) {
    return CarBrandDataModel(
      id: json['brandid'],
      name: json['brandname'],
      latinName: json['brandlatinname'],
      image: json['image'] != null ? base64Decode(json["image"]) : null,
    );
  }
}