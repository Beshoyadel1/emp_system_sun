import 'package:flutter/cupertino.dart';

class ProviderBranchModel {
  final int? branchId;
  final String? branchName;
  final String? branchLatinName;
  final String? address;
  final String? nationalAddress;
  final double? latitude;
  final double? longitude;
  final String? addressText;
  final String? addressLatinText;
  final int? providerId;
  final bool? isActive;

  ProviderBranchModel({
     this.branchId,
     this.branchName,
     this.branchLatinName,
     this.address,
    this.nationalAddress,
    this.latitude,
    this.longitude,
     this.addressText,
     this.addressLatinText,
     this.providerId,
     this.isActive=true,
  });

  factory ProviderBranchModel.fromJson(Map<String, dynamic> json) {
    final fields = json.map((key, value) => MapEntry(key.toLowerCase(), value));
    final legacyCoordinates = fields['address']?.toString().split(',');
    double? coordinate(String key, int index) {
      final value = double.tryParse(fields[key]?.toString() ?? '');
      if (value != null && value.isFinite) return value;
      if (legacyCoordinates?.length != 2) return null;
      final legacy = double.tryParse(legacyCoordinates![index].trim());
      return legacy?.isFinite == true ? legacy : null;
    }

    return ProviderBranchModel(
      nationalAddress: fields['nationaladdress']?.toString(),
      latitude: coordinate('lat', 0),
      longitude: coordinate('long', 1),
      branchId: fields['branchid'],
      branchName: fields['branchname'] ?? '',
      branchLatinName: fields['branchlatinname'] ?? '',
      address: fields['address'] ?? '',
      addressText: fields['addresstext'] ?? '',
      addressLatinText: fields['addresslatintext'] ?? '',
      providerId: fields['provid'],
      isActive: fields['isactive'] ?? false,
    );
  }

  static List<ProviderBranchModel> fromList(List list) {
    return list.map((e) => ProviderBranchModel.fromJson(e)).toList();
  }
  String getBranchName(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic
        ? (branchName ?? "")
        : (branchLatinName ?? "");
  }
  String getAddressText(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic
        ? (addressText ?? "")
        : (addressLatinText ?? "");
  }
}