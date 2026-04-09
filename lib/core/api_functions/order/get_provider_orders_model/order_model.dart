import 'dart:convert';
import 'dart:typed_data';
import '../../../../../core/api_functions/order/get_provider_orders_model/service_model.dart';
import '../../../../../core/api_functions/order/get_provider_orders_model/service_package_model.dart';

class OrderModel {
  final int? id;
  final int? userId;
  final String? username;
  final int? userType;
  final int? orderStatus;
  final String? orderDate;
  final num? totalPrice;
  final int? providerId;
  final String? providerName;
  final String? providerLatinName;
  final Uint8List? providerImage;
  final String? branchName;
  final String? branchLatinName;
  final List<ServiceModel>? services;
  final List<dynamic>? provServices;
  final List<ServicePackageModel>? servicePackages;
  final dynamic car;

  OrderModel({
     this.id,
     this.userId,
     this.username,
     this.userType,
     this.orderStatus,
     this.orderDate,
     this.totalPrice,
     this.providerId,
     this.providerName,
     this.providerLatinName,
     this.providerImage,
     this.branchName,
     this.branchLatinName,
     this.services,
     this.provServices,
     this.servicePackages,
     this.car,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] ?? 0,
      userId: json['userid'] ?? 0,
      username: json['username'] ?? '',
      userType: json['usertype'] ?? 0,
      orderStatus: json['orderstatus'] ?? 0,
      orderDate: json['orderdate'] ?? '',
      totalPrice: json['totalprice'] ?? 0,

      providerId: json['provid'] ?? 0,
      providerName: json['provname'] ?? '',
      providerLatinName: json['provlatinname'] ?? '',
      providerImage: json['provimage']!= null ? base64Decode(json["provimage"]) : null,

      branchName: json['branchname'] ?? '',
      branchLatinName: json['branchlatinname'] ?? '',

      services: (json['services'] as List? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),

      provServices: json['provServices'] ?? [],

      servicePackages: (json['servicePackages'] as List? ?? [])
          .map((e) => ServicePackageModel.fromJson(e))
          .toList(),

      car: json['car'],
    );
  }
}
