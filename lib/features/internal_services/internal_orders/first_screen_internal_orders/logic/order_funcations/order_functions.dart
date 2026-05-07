import 'package:flutter/material.dart';
import '../../../../../../core/api_functions/order/get_provider_orders_model/service_model.dart';
import '../../../../../../core/language/language.dart';
import '../../../../../../core/language/language_constant.dart';

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
  static String formatDateFromDateTime(DateTime? date) {
    if (date == null) return "";
    return "${date.year}/${date.month}/${date.day}";
  }
  static String formatTime(DateTime? date) {
    if (date == null) return "";
    return "${date.hour}:${date.minute}";
  }
  static String valueOrEmpty(dynamic value, BuildContext context) {
    if (value == null || value.toString().trim().isEmpty) {
      return AppLocalizations.of(context).translate(AppLanguageKeys.empty);
    }
    return value.toString();
  }
  static String getGenderText(dynamic gender, BuildContext context) {
    if (gender == null) {
      return AppLocalizations.of(context)
          .translate(AppLanguageKeys.empty);
    }

    if (gender.toString() == '0') {
      return AppLocalizations.of(context)
          .translate(AppLanguageKeys.male);
    } else if (gender.toString() == '1') {
      return AppLocalizations.of(context)
          .translate(AppLanguageKeys.female);
    }

    return AppLocalizations.of(context)
        .translate(AppLanguageKeys.empty);
  }
}