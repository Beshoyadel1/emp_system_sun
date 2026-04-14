import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';

class WorkTeamUserModel {
  final int userId;
  final int userType;
  final String name;
  final String latinName;
  final String jobName;
  final String latinJobName;
  final Uint8List? image;

  WorkTeamUserModel({
    required this.userId,
    required this.userType,
    required this.name,
    required this.latinName,
    required this.jobName,
    required this.latinJobName,
    this.image,
  });

  factory WorkTeamUserModel.fromJson(Map<String, dynamic> json) {
    return WorkTeamUserModel(
      userId: json['userid'] ?? 0,
      userType: json['usertype'] ?? 0,
      name: json['name'] ?? "",
      latinName: json['latinname'] ?? "",
      jobName: json['jobname'] ?? "",
      latinJobName: json['latinjobname'] ?? "",
      image: json['image']!= null ? base64Decode(json["image"]) : null,
    );
  }

  bool _isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  String getName(BuildContext context) {
    return _isEnglish(context)
        ? (latinName.isNotEmpty ? latinName : name)
        : name;
  }

  String getJobName(BuildContext context) {
    return _isEnglish(context)
        ? (latinJobName.isNotEmpty ? latinJobName : jobName)
        : jobName;
  }
}