import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import '../../../../core/language/language_cubit/language_cubit.dart';

class ProductCategoryModel {
  final int? id;
  final String? name;
  final String? latinName;
  final Uint8List? image;
  ProductCategoryModel({
    this.id,
    this.name,
    this.latinName,
    this.image,
  });

  factory ProductCategoryModel.fromJson(Map<String, dynamic> json) {
    return ProductCategoryModel(
      id: json['id'],
      name: json['name'],
      latinName: json['latinname'],
      image: json['image'] != null ? base64Decode(json["image"]) : null,
    );
  }

  String getName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (name ?? "")
        : (latinName ?? "");
  }
}