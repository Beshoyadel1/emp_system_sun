import 'package:flutter/cupertino.dart';
import '../../../../core/language/language_cubit/language_cubit.dart';

class ProviderBranchModel {
  final int? branchId;
  final String? branchName;
  final String? branchLatinName;
  final String? address;
  final String? addressText;
  final String? addressLatinText;
  final int? providerId;
  final bool? isActive;

  ProviderBranchModel({
     this.branchId,
     this.branchName,
     this.branchLatinName,
     this.address,
     this.addressText,
     this.addressLatinText,
     this.providerId,
     this.isActive=true,
  });

  factory ProviderBranchModel.fromJson(Map<String, dynamic> json) {
    return ProviderBranchModel(
      branchId: json['branchid'],
      branchName: json['branchname'] ?? '',
      branchLatinName: json['branchlatinname'] ?? '',
      address: json['address'] ?? '',
      addressText: json['addresstext'] ?? '',
      addressLatinText: json['addresslatintext'] ?? '',
      providerId: json['provid'],
      isActive: json['isactive'] ?? false,
    );
  }

  static List<ProviderBranchModel> fromList(List list) {
    return list.map((e) => ProviderBranchModel.fromJson(e)).toList();
  }
  String getBranchName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (branchName ?? "")
        : (branchLatinName ?? "");
  }
  String getAddressText(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (addressText ?? "")
        : (addressLatinText ?? "");
  }
}