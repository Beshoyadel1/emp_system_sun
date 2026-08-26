import 'dart:convert';
import 'dart:typed_data';

class CreateUpdateHarageRequest {
  final int? id;

  final int? userId;
  final int? userType;

  final int? carId;
  final int? carBrandId;
  final int? carModelId;

  final bool? isNew;
  final int? releaseDate;
  final int? transmissionType;
  final int? fuelType;
  final int? kilometers;

  final String? description;
  final String? addressText;

  final num? price;
  final num? cost;

  final int? branchId;

  final List<Uint8List> images;

  CreateUpdateHarageRequest({
    this.id,
    this.userId,
    this.userType,
    this.carId,
    this.carBrandId,
    this.carModelId,
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
    this.images = const [],
  });

  Map<String, dynamic> toCreateJson() {
    final Map<String, dynamic> json = {
      "USERID": userId,
      "USERTYPE": userType,

      if (carId != null)
        "CARID": carId,

      if (carBrandId != null)
        "CARBRANDID": carBrandId,

      if (carModelId != null)
        "CARMODELID": carModelId,

      "ISNEW": isNew,
      "RELEASEDATE": releaseDate,
      "TRANSMISSIONTYPE": transmissionType,
      "FUELTYPE": fuelType,
      "KILOMETERS": kilometers,
      "DESCRIPTION": description,
      "ADDRESSTEXT": addressText,
      "PRICE": price,
      "COST": cost,
      "BRANCHID": branchId,

      "Images": images
          .map((image) => base64Encode(image))
          .toList(),
    };

    return json;
  }

  // ============================================================
  // UPDATE
  // ============================================================

  Map<String, dynamic> toUpdateJson() {
    final Map<String, dynamic> json = {
      "ID": id,

      "USERID": userId,
      "USERTYPE": userType,

      if (carId != null)
        "CARID": carId,

      if (carBrandId != null)
        "CARBRANDID": carBrandId,

      if (carModelId != null)
        "CARMODELID": carModelId,

      "ISNEW": isNew,
      "RELEASEDATE": releaseDate,
      "TRANSMISSIONTYPE": transmissionType,
      "FUELTYPE": fuelType,
      "KILOMETERS": kilometers,
      "DESCRIPTION": description,
      "ADDRESSTEXT": addressText,
      "PRICE": price,
      "COST": cost,
      "BRANCHID": branchId,

      "Images": images
          .map((image) => base64Encode(image))
          .toList(),
    };

    return json;
  }
}