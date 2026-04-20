import 'package:flutter/cupertino.dart';

class PackageModelGetPackageRepository {
  final int packageId;
  final String packageName;
  final String packageLatinName;
  final double annualPrice;
  final double monthPrice;
  final String packageDesc;
  final String packageLatinDesc;

  PackageModelGetPackageRepository({
    required this.packageId,
    required this.packageName,
    required this.packageLatinName,
    required this.annualPrice,
    required this.monthPrice,
    required this.packageDesc,
    required this.packageLatinDesc,
  });

  factory PackageModelGetPackageRepository.fromJson(Map<String, dynamic> json) {
    return PackageModelGetPackageRepository(
      packageId: json['packageid'] ?? 0,
      packageName: json['packagename'] ?? "",
      packageLatinName: json['packagelatinname'] ?? "",
      annualPrice: (json['annualprice'] ?? 0).toDouble(),
      monthPrice: (json['monthprice'] ?? 0).toDouble(),
      packageDesc: json['packagedisc'] ?? "",
      packageLatinDesc: json['packagelatindisc'] ?? "",
    );
  }
  bool _isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }

  String getName(BuildContext context) {
    return _isEnglish(context) ? packageLatinName : packageName;
  }

  String getDescription(BuildContext context) {
    return _isEnglish(context) ? packageLatinDesc : packageDesc;
  }
}