import 'package:flutter/material.dart';
import '../../../../core/language/language_cubit/language_cubit.dart';

class GetProviderTotalRateAndEmployeeAndBalanceModel {
  final double? averageRate;
  final double? totalBalance;
  final List<TopEmployee> topEmployees;
  final List<AccountBalance> accountsBalance;

  GetProviderTotalRateAndEmployeeAndBalanceModel({
    this.averageRate,
    this.totalBalance,
    required this.topEmployees,
    required this.accountsBalance,
  });

  factory GetProviderTotalRateAndEmployeeAndBalanceModel.fromJson(
      Map<String, dynamic> json) {
    return GetProviderTotalRateAndEmployeeAndBalanceModel(
      averageRate: (json['averageRate'] ?? 0).toDouble(),
      totalBalance: (json['totalBalance'] ?? 0).toDouble(),
      topEmployees: (json['topEmployees'] as List)
          .map((e) => TopEmployee.fromJson(e))
          .toList(),
      accountsBalance: (json['accountsBalance'] as List)
          .map((e) => AccountBalance.fromJson(e))
          .toList(),
    );
  }
}

class TopEmployee {
  final String? employeeName;
  final String? employeeLatinName;
  final int? orderCount;
  final String? jobName;
  final String? jobLatinName;

  TopEmployee({
    this.employeeName,
    this.employeeLatinName,
    this.orderCount,
    this.jobName,
    this.jobLatinName,
  });

  factory TopEmployee.fromJson(Map<String, dynamic> json) {
    return TopEmployee(
      employeeName: json['employeeName'],
      employeeLatinName: json['employeeLatinName'],
      orderCount: json['orderCount'],
      jobName: json['jobName'],
      jobLatinName: json['jobLatinName'],
    );
  }

  String getName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (employeeName ?? "")
        : (employeeLatinName ?? "");
  }

  String getJobName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (jobName ?? "")
        : (jobLatinName ?? "");
  }
}

class AccountBalance {
  final String? serviceName;
  final String? serviceLatinName;
  final double? amount;
  final int? recentOrderId;

  AccountBalance({
    this.serviceName,
    this.serviceLatinName,
    this.amount,
    this.recentOrderId,
  });

  factory AccountBalance.fromJson(Map<String, dynamic> json) {
    return AccountBalance(
      serviceName: json['serviceName'],
      serviceLatinName: json['serviceLatinName'],
      amount: (json['amount'] ?? 0).toDouble(),
      recentOrderId: json['recentOrderId'],
    );
  }

  String getName(BuildContext context) {
    final isArabic =
        LanguageCubit.get(context).isAllAppLanguageArabic;

    return isArabic
        ? (serviceName ?? "")
        : (serviceLatinName ?? "");
  }
}