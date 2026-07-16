import 'package:flutter/foundation.dart';
import '../../../../../../core/theming/auth_local_storage.dart';
import 'dart:convert';

String decodeArabic(String? text) {
  if (text == null || text.isEmpty) {
    return "";
  }

  try {
    return utf8.decode(latin1.encode(text));
  } catch (_) {
    return text;
  }
}
class ReceiveMessageNotificationModel {
  final int? userId;
  final int? userType;
  final ReceiveMessageNotificationData? data;

  ReceiveMessageNotificationModel({
    this.userId,
    this.userType,
    this.data,
  });

  factory ReceiveMessageNotificationModel.fromJson(
      Map<String, dynamic> json,
      ) {
    return ReceiveMessageNotificationModel(
      userId: json["userId"],
      userType: json["userType"],
      data: json["data"] == null
          ? null
          : ReceiveMessageNotificationData.fromJson(json["data"]),
    );
  }

  Future<bool> canView() async {
    final currentUser = await AuthLocalStorage.getUser();

    if (currentUser == null) {
      return false;
    }

    if (userType != currentUser.type) {
      debugPrint("❌ UserType Not Match");
      return false;
    }

    if (userId != null &&
        userId != 0 &&
        userId != currentUser.userid) {
      debugPrint("❌ UserId Not Match");
      return false;
    }

    debugPrint("✅ ReceiveMessage Accepted");
    return true;
  }
}
class ReceiveMessageNotificationData {
  final String? title;
  final String? body;
  final ReceiveMessageData? data;

  ReceiveMessageNotificationData({
    this.title,
    this.body,
    this.data,
  });

  factory ReceiveMessageNotificationData.fromJson(
      Map<String, dynamic> json,
      ) {
    return ReceiveMessageNotificationData(
      title: json["title"],
      body: json["body"],
      data: json["data"] == null
          ? null
          : ReceiveMessageData.fromJson(json["data"]),
    );
  }
}
class ReceiveMessageData {
  final String? type;
  final String? id;
  final String? fromUser;
  final String? toUser;
  final String? message;
  final String? date;
  final String? viewed;
  final String? fromUserType;
  final String? toUserType;
  final String? isClosed;
  final String? fromUserName;

  ReceiveMessageData({
    this.type,
    this.id,
    this.fromUser,
    this.toUser,
    this.message,
    this.date,
    this.viewed,
    this.fromUserType,
    this.toUserType,
    this.isClosed,
    this.fromUserName,
  });

  factory ReceiveMessageData.fromJson(
      Map<String, dynamic> json,
      ) {
    return ReceiveMessageData(
      type: json["type"]?.toString(),
      id: json["id"]?.toString(),
      fromUser: json["fromuser"]?.toString(),
      toUser: json["touser"]?.toString(),
      message: decodeArabic( json["message"]?.toString(),),
      date: json["date"]?.toString(),
      viewed: json["viewed"]?.toString(),
      fromUserType: json["fromusertype"]?.toString(),
      toUserType: json["tousertype"]?.toString(),
      isClosed: json["isclosed"]?.toString(),
      fromUserName: decodeArabic( json["fromusername"]?.toString(),),
    );
  }
}