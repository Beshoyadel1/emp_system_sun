import '../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/car_model.dart';
import '../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/user_model.dart';
import '../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/harage_status_model.dart';
import '../../../../../../features/cars_haraj_page/data/model/get_all_harage_model/chat_harag_model.dart';
import 'dart:convert';
import 'dart:typed_data';

class HarageData {
  final int? id;
  final int? userid;
  final int? usertype;
  final int? carid;
  final int? carbrandid;
  final int? carmodelid;

  final bool? isNew;
  final String? releaseDate;

  final int? transmissionType;
  final int? fuelType;
  final int? kilometers;

  final String? description;
  final String? addressText;

  final num? price;
  final num? cost;

  final int? branchId;

  final bool? isSold;

  final int? status;

  final HarageStatusModel? currentStatus;

  final List<HarageStatusModel> statusHistory;

  final int? commentsNumber;
  final String? sellDate;

  final UserModel? user;
  final CarModel? car;

  final List<Uint8List> images;

  // =========================
  // CHATS
  // =========================
  final List<ChatHaragModel> chats;

  HarageData({
    this.id,
    this.userid,
    this.usertype,
    this.carid,
    this.carbrandid,
    this.carmodelid,
    this.isNew,
    this.releaseDate,
    this.transmissionType,
    this.fuelType,
    this.kilometers,
    this.description,
    this.addressText,
    this.price,
    this.cost,
    this.branchId,
    this.isSold,
    this.status,
    this.currentStatus,
    this.statusHistory = const [],
    this.commentsNumber,
    this.sellDate,
    this.user,
    this.car,
    this.images = const [],
    this.chats = const [],
  });

  factory HarageData.fromJson(Map<String, dynamic> json) {
    return HarageData(
      id: json['id'],
      userid: json['userid'],
      usertype: json['usertype'],

      carid: json['carid'],
      carbrandid: json['carbrandid'],
      carmodelid: json['carmodelid'],

      isNew: json['isnew'],

      releaseDate: json['releasedate']?.toString(),

      transmissionType: json['transmissiontype'],
      fuelType: json['fueltype'],
      kilometers: json['kilometers'],

      description: json['description']?.toString(),
      addressText: json['addresstext']?.toString(),

      price: json['price'],
      cost: json['cost'],

      branchId: json['branchid'],

      isSold: json['issold'],

      status: json['status'],

      // =========================
      // CURRENT STATUS
      // =========================
      currentStatus: json['currentStatus'] is Map<String, dynamic>
          ? HarageStatusModel.fromJson(
        json['currentStatus'] as Map<String, dynamic>,
      )
          : null,

      // =========================
      // STATUS HISTORY
      // =========================
      statusHistory: json['statusHistory'] is List
          ? (json['statusHistory'] as List)
          .whereType<Map<String, dynamic>>()
          .map(
            (e) => HarageStatusModel.fromJson(e),
      )
          .toList()
          : [],

      commentsNumber: json['commentsnumber'],

      sellDate: json['selldate']?.toString(),

      // =========================
      // USER
      // =========================
      user: json['user'] is Map<String, dynamic>
          ? UserModel.fromJson(
        json['user'] as Map<String, dynamic>,
      )
          : null,

      // =========================
      // CAR
      // =========================
      car: json['car'] is Map<String, dynamic>
          ? CarModel.fromJson(
        json['car'] as Map<String, dynamic>,
      )
          : null,

      // =========================
      // IMAGES
      // =========================
      images: json['images'] is List
          ? (json['images'] as List)
          .whereType<String>()
          .map(
            (image) => base64Decode(image),
      )
          .toList()
          : [],

      // =========================
      // CHATS
      // =========================
      chats: json['chats'] is List
          ? (json['chats'] as List)
          .whereType<Map<String, dynamic>>()
          .map(
            (e) => ChatHaragModel.fromJson(e),
      )
          .toList()
          : [],
    );
  }
}