import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';

class EmployeeServiceModel {
  final int? id;
  final int? parentId;
  final String? name;
  final String? latinName;

  final Uint8List? image;

  EmployeeServiceModel({
    this.id,
    this.name,
    this.latinName,
    this.image,
    this.parentId,
  });

  factory EmployeeServiceModel.fromJson(Map<String, dynamic> json) {
    return EmployeeServiceModel(
      id: json['serviceId'] ?? 0,
      name: json['serviceName']?.toString() ?? "",
      latinName: json['serviceLatinName']?.toString() ?? "",
      parentId: json['parentId'] ?? 0,
      image: json['image'] != null
          ? base64Decode(json['image'])
          : null,
    );
  }
  String getName(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic
        ? (name ?? "")
        : (latinName ?? "");
  }
}
