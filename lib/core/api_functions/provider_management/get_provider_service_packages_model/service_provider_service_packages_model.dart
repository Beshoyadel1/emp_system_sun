import 'dart:convert';
import 'dart:typed_data';

class ServiceProviderServicePackagesModel {
  final int? id;
  final int? parentId;
  final String? name;
  final String? latinName;
  final Uint8List? image;

  ServiceProviderServicePackagesModel({
     this.id,
     this.parentId,
     this.name,
     this.latinName,
     this.image,
  });

  factory ServiceProviderServicePackagesModel.fromJson(Map<String, dynamic> json) {
    return ServiceProviderServicePackagesModel(
      id: json['id'],
      parentId: json['parentid'],
      name: json['name'],
      latinName: json['latinname'],
      image: json['image']!= null ? base64Decode(json["image"]) : null,
    );
  }
}
