import 'package:emp_system_sun/core/api_functions/order/get_provider_orders_model/service_model.dart';
import 'package:flutter/material.dart';

class OrderFunctions {
  static bool isEnglish(BuildContext context) {
    return Localizations.localeOf(context).languageCode == 'en';
  }
  static String getServiceTitle({
    required BuildContext context,
    required ServiceModel? service,
  }) {
    if (service == null) return "";

    return isEnglish(context)
        ? (service.latinName ?? "")
        : (service.name ?? "");
  }
  static String formatDate(String? date) {
    if (date == null || date.isEmpty) return "";

    final parsed = DateTime.tryParse(date);
    if (parsed == null) return date;

    return "${parsed.day}/${parsed.month}/${parsed.year}";
  }
}