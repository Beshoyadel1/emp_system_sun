import 'package:flutter/cupertino.dart';
import '../../../../core/language/language_cubit/language_cubit.dart';

class SummaryCard {
  final String? serviceName;
  final String? serviceLatinName;
  final int? orderCount;
  final double? totalAmount;
  final double? percentageChange;
  final bool? isIncrease;

  SummaryCard({
    this.serviceName,
    this.serviceLatinName,
    this.orderCount,
    this.totalAmount,
    this.percentageChange,
    this.isIncrease,
  });

  factory SummaryCard.fromJson(Map<String, dynamic> json) {
    return SummaryCard(
      serviceName: json['serviceName'],
      serviceLatinName: json['serviceLatinName'],
      orderCount: json['orderCount'],
      totalAmount: (json['totalAmount'] ?? 0).toDouble(),
      percentageChange: (json['percentageChange'] ?? 0).toDouble(),
      isIncrease: json['isIncrease'],
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