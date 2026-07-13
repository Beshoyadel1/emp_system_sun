import 'dart:convert';
import 'package:flutter/cupertino.dart';
import '../../../../../../features/auth_page/data/datasource/login_datasource/login_repository.dart';

class NewOrderNotificationsModel {
  final int? userId;
  final int? userType;
  final String? title;
  final String? body;
  final NewOrderData? data;

  NewOrderNotificationsModel({
    this.userId,
    this.userType,
    this.title,
    this.body,
    this.data,
  });

  factory NewOrderNotificationsModel.fromJson(
      Map<String, dynamic> json,
      ) {
    final bodyData = Map<String, dynamic>.from(json["data"]);

    return NewOrderNotificationsModel(
      userId: json["userId"] ?? 0,
      userType: json["userType"] ?? 0,
      title: bodyData["title"] ?? "",
      body: bodyData["body"] ?? "",
      data: NewOrderData?.fromJson(
        Map<String, dynamic>.from(bodyData["data"]),
      ),
    );
  }
}

class NewOrderData {
  final String? type;
  final int? orderId;
  final OrderInfo? orderInfo;

  NewOrderData({
    this.type,
    this.orderId,
    this.orderInfo,
  });

  factory NewOrderData.fromJson(
      Map<String, dynamic> json,
      ) {
    return NewOrderData(
      type: json["type"]?.toString() ?? "",
      orderId: _parseInt(json["orderId"]),
      orderInfo: OrderInfo.fromJson(
        Map<String, dynamic>.from(
          jsonDecode(json["orderInfo"].toString()),
        ),
      ),
    );
  }
}

class OrderInfo {
  final int? id;
  final int? userId;
  final int? userType;
  final int? orderStatus;
  final String? userName;
  final DateTime? orderDate;
  final double? totalPrice;

  OrderInfo({
    this.id,
    this.userId,
    this.userType,
    this.orderStatus,
    this.userName,
    this.orderDate,
    this.totalPrice,
  });

  factory OrderInfo.fromJson(
      Map<String, dynamic> json,
      ) {
    return OrderInfo(
      id: _parseInt(json["ID"]),
      userId: _parseInt(json["USERID"]),
      userType: _parseInt(json["USERTYPE"]),
      orderStatus: _parseInt(json["ORDERSTATUS"]),
      userName: json["USERNAME"]?.toString() ?? "",
      orderDate: DateTime.tryParse(
        json["ORDERDATE"]?.toString() ?? "",
      ),
      totalPrice: double.tryParse(json["TOTALPRICE"]?.toString() ?? "0") ?? 0,
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

    if (userId != currentUser.userid&&userId != 0&&userId != null) {
      debugPrint("❌ UserId Not Match");
      return false;
    }

    debugPrint("✅ Order Accepted");
    return true;
  }
}

int _parseInt(dynamic value) {
  if (value == null) return 0;

  if (value is int) return value;

  if (value is num) return value.toInt();

  if (value is String) {
    return int.tryParse(value) ?? 0;
  }

  return 0;
}