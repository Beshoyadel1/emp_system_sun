import 'package:flutter/cupertino.dart';

class AddBranchRequest {
  final int? branchId;
  final String? branchName;
  final String? branchLatinName;
  final String? nationalAddress;
  final double? latitude;
  final double? longitude;
  final String? addressText;
  final String? addressLatinText;
  final bool? isActive;

  AddBranchRequest({
    this.branchId,
     this.branchName,
     this.branchLatinName,
     this.nationalAddress,
    this.latitude,
    this.longitude,
     this.addressText,
     this.addressLatinText,
    this.isActive = true,
  });

  Map<String, dynamic> toJson(int providerId) {
    return {
      if (branchId != null) "branchid": branchId,
      if (branchName != null) "branchname": branchName,
      if (branchLatinName != null) "branchlatinname": branchLatinName,
      if (nationalAddress != null) "nationaladdress": nationalAddress,
      if (latitude != null) "lat": latitude,
      if (longitude != null) "long": longitude,
      if (addressText != null) "addresstext": addressText,
      if (addressLatinText != null) "addresslatintext": addressLatinText,
      "provid": providerId,
      "isactive": isActive,
    };
  }

  String? getBranchName(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic ? branchName : branchLatinName;
  }

  String? getAddressText(BuildContext context) {
    final isArabic =
        (Localizations.localeOf(context).languageCode == 'ar');

    return isArabic ? addressText : addressLatinText;
  }
}