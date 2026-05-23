import 'package:flutter/material.dart';
import '../../../../../core/language/language_cubit/language_cubit.dart';

class GetProviderTotalRateAndEmployeeAndBalanceModel {
  final double averageRate;
  final double totalBalance;
  final List<TopEmployee> topEmployees;
  final List<AccountBalance> accountsBalance;

  GetProviderTotalRateAndEmployeeAndBalanceModel({
    required this.averageRate,
    required this.totalBalance,
    required this.topEmployees,
    required this.accountsBalance,
  });

  factory GetProviderTotalRateAndEmployeeAndBalanceModel.fromJson(
      Map<String, dynamic> json) {

    final data = json['data'] ?? {};

    return GetProviderTotalRateAndEmployeeAndBalanceModel(
      averageRate: (data['averageRate'] ?? 0).toDouble(),

      totalBalance: (data['totalBalance'] ?? 0).toDouble(),

      topEmployees: (data['topEmployees'] as List<dynamic>? ?? [])
          .map((e) => TopEmployee.fromJson(e))
          .toList(),

      accountsBalance:
      (data['accountsBalance'] as List<dynamic>? ?? [])
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