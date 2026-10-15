import 'package:flutter/widgets.dart';

import '../language/language.dart';
import '../language/language_constant.dart';

class AppCurrency {
  static const code = 'SAR';

  static String format(BuildContext context, num? amount,
      {int decimalDigits = 2}) {
    final currency =
        AppLocalizations.of(context).translate(AppLanguageKeys.sar);
    return '${(amount ?? 0).toStringAsFixed(decimalDigits)} $currency';
  }
}
