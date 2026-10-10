import 'dart:convert';
import 'dart:typed_data';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/service_model.dart';
import 'package:emp_system_sun/features/internal_services/data/model/get_provider_orders_model/service_package_model.dart';
import 'package:emp_system_sun/features/notifications/data/model/notification_payload.dart';

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
  final int? branchId;
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
    this.branchId,
    this.branchLatinName,
    this.services,
    this.provServices,
    this.servicePackages,
    this.car,
  });
  factory OrderModel.fromJson(Map<String, dynamic> json) {
    json = {for (final e in json.entries) NotificationPayload.normalize(e.key): e.value};
    int? integer(String key) => int.tryParse('${json[key]}');
    return OrderModel(
      id: integer('id'),
      userId: integer('userid'),
      username: json['username'] ?? '',
      userType: integer('usertype'),
      orderStatus: integer('orderstatus') ?? integer('status'),
      orderDate: (json['orderdate'] ?? json['date'])?.toString(),
      totalPrice: num.tryParse('${json['totalprice']}'),

      providerId: integer('provid'),
      providerName: json['provname'] ?? '',
      providerLatinName: json['provlatinname'] ?? '',
      providerImage: _image(json['provimage']),

      branchName: json['branchname'] ?? '',
      branchId: integer('branchid'),
      branchLatinName: json['branchlatinname'] ?? '',

      services: (json['services'] as List? ?? [])
          .map((e) => ServiceModel.fromJson(e))
          .toList(),

      provServices: json['provservices'] ?? [],

      servicePackages: (json['servicepackages'] as List? ?? [])
          .map((e) => ServicePackageModel.fromJson(e))
          .toList(),

      car: json['car'],
    );
  }

  /// Missing fields preserve the REST snapshot, including images omitted by FCM.
  OrderModel applyPatch(Map<String, dynamic> patch) {
    patch = {for (final e in patch.entries) NotificationPayload.normalize(e.key): e.value};
    int? integer(String key, int? previous) => patch.containsKey(key)
      ? int.tryParse('${patch[key]}') : previous;
    String? text(String key, String? previous) => patch.containsKey(key) ? patch[key]?.toString() : previous;
    List<ServiceModel>? updatedServices = services;
    if (patch['services'] is List) {
      updatedServices = (patch['services'] as List).whereType<Map>().map((raw) {
        final data = {for (final e in raw.entries) NotificationPayload.normalize(e.key.toString()): e.value};
        final id = int.tryParse('${data['id']}');
        final matches = services?.where((s) => s.id == id) ?? <ServiceModel>[];
        final old = matches.isEmpty ? null : matches.first;
        return ServiceModel(id: id, parentId: data.containsKey('parentid') ? int.tryParse('${data['parentid']}') : old?.parentId,
          name: data['name']?.toString() ?? old?.name,
          latinName: data['latinname']?.toString() ?? old?.latinName,
          image: data.containsKey('image') ? _image(data['image']) : old?.image);
      }).toList();
    }
    return OrderModel(
      id: integer('id', id), userId: integer('userid', userId), username: text('username', username),
      userType: integer('usertype', userType), orderStatus: integer('orderstatus', orderStatus),
      orderDate: text('orderdate', orderDate), totalPrice: patch.containsKey('totalprice') ? num.tryParse('${patch['totalprice']}') : totalPrice,
      providerId: integer('provid', providerId), providerName: text('provname', providerName),
      providerLatinName: text('provlatinname', providerLatinName),
      providerImage: patch.containsKey('provimage') ? _image(patch['provimage']) : providerImage,
      branchId: integer('branchid', branchId), branchName: text('branchname', branchName),
      branchLatinName: text('branchlatinname', branchLatinName), services: updatedServices,
      provServices: patch['provservices'] is List ? patch['provservices'] : provServices,
      servicePackages: patch['servicepackages'] is List ? (patch['servicepackages'] as List).whereType<Map>()
        .map((e) => ServicePackageModel.fromJson(Map<String, dynamic>.from(e))).toList() : servicePackages,
      car: patch.containsKey('car') ? patch['car'] : car,
    );
  }

  static Uint8List? _image(dynamic raw) {
    if (raw is Uint8List) return raw;
    if (raw is String && raw.isNotEmpty) {
      try { return base64Decode(raw); } catch (_) {}
    }
    return null;
  }
}
