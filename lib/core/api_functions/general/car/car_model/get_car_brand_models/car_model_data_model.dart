import 'dart:convert';
import 'dart:typed_data';

class CarModelDataModel {
  final int? id;
  final String? name;
  final int? brandId;
  final Uint8List? image;

  CarModelDataModel({
    this.id,
    this.name,
    this.brandId,
    this.image,
  });

  factory CarModelDataModel.fromJson(Map<String, dynamic> json) {
    return CarModelDataModel(
      id: json['modelid'],
      name: json['modelname'],
      brandId: json['carbrandid'],
      image: json['image'] != null
          ? base64Decode(json['image'])
          : null,
    );
  }
}