import 'package:flutter/cupertino.dart';

class PackageProviderServicePackagesModel {
  final int id;
  final int provId;
  final String name;
  final String latinName;
  final String items;
  final num price;
  final num taxId;

  PackageProviderServicePackagesModel({
    required this.id,
    required this.provId,
    required this.name,
    required this.latinName,
    required this.items,
    required this.price,
    required this.taxId,
  });

  factory PackageProviderServicePackagesModel.fromJson(Map<String, dynamic> json) {
    return PackageProviderServicePackagesModel(
      id: json['id'],
      provId: json['provid'],
      name: json['name'],
      latinName: json['latinname'],
      items: json['items'],
      price: json['price'],
      taxId: json['taxid'],
    );
  }
  String getLocalizedName(BuildContext context) {
    final lang = Localizations.localeOf(context).languageCode;

    return lang == 'ar' ? name : latinName;
  }
}
