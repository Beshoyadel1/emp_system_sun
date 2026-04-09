import 'dart:convert';
import 'dart:typed_data';

class ServiceSettingModel {
  final int? id,parentId;
  final String? name;
  final String? latinName;
  final Uint8List? image;

  ServiceSettingModel({
     this.id,
     this.name,
     this.latinName,
     this.image,
     this.parentId,
  });

  factory ServiceSettingModel.fromJson(Map<String, dynamic> json) {
    return ServiceSettingModel(
      id: json['id'],
      parentId: json['parentid'],
      name: json['name'],
      latinName: json['latinname'],
      image: base64Decode(json['image']),
    );
  }
}