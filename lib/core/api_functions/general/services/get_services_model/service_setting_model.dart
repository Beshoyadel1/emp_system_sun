import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import '../../../../../../core/language/language_cubit/language_cubit.dart';

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
  String getName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (name ?? "")
        : (latinName ?? "");
  }
}