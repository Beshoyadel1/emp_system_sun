import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';

class UserModel {
  final int? id;
  final int? type;
  final String? name;
  final String? latinName;
  final Uint8List? image;
  final String? branchName;
  final String? branchLatinName;

  UserModel({
    this.id,
    this.type,
    this.name,
    this.latinName,
    this.image,
    this.branchName,
    this.branchLatinName,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      type: json['type'],
      name: json['name'],
      latinName: json['latinname'],
      image: json['image'] != null
          ? base64Decode(json['image'])
          : null,
      branchName: json['branchname'],
      branchLatinName: json['branchlatinname'],
    );
  }

  String getName(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic
        ? (name ?? '')
        : (latinName ?? '');
  }

  String getBranch(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic
        ? (branchName ?? '')
        : (branchLatinName ?? '');
  }
}
