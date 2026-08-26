import 'dart:convert';
import 'dart:typed_data';

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

  factory CarModelDataModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final data =
        json['data'] as Map<String, dynamic>? ?? json;

    return CarModelDataModel(
      id: int.tryParse(
        data['modelid']?.toString() ?? '',
      ),
      name: data['modelname']?.toString() ?? '',
      brandId: int.tryParse(
        data['carbrandid']?.toString() ?? '',
      ),
      image: data['image'] != null
          ? base64Decode(data['image'].toString())
          : null,
    );
  }
}