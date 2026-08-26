import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_cubit/language_cubit.dart';

class CarModel {
  final int? id;
  final int? carBrandId;
  final int? carModelId;
  final String? name;
  final String? brandName;
  final String? brandLatinName;
  final Uint8List? brandImage;
  final String? modelName;
  final Uint8List? carImage;

  CarModel({
    this.id,
    this.carBrandId,
    this.carModelId,
    this.name,
    this.brandName,
    this.brandLatinName,
    this.brandImage,
    this.modelName,
    this.carImage,
  });

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      id: json['id'],
      carBrandId: json['carbrandid'],
      carModelId: json['carmodelid'],
      name: json['name'],
      brandName: json['brandname'],
      brandLatinName: json['brandlatinname'],
      brandImage: json['brandimage'] != null
          ? base64Decode(json['brandimage'])
          : null,
      modelName: json['modelname'],
      carImage: json['carimage'] != null
          ? base64Decode(json['carimage'])
          : null,
    );
  }

  String getBrand(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (brandName ?? '')
        : (brandLatinName ?? '');
  }
}
