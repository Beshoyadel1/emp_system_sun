import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../theming/colors.dart';
import '../../theming/fonts.dart';
import '../../theming/text_styles.dart';

class AppSnackBar {
  static void showSuccess(String message) {
    _show(message, Colors.green);
  }

  static void showError(String message) {
    _show(message, Colors.red);
  }

  static void showInfo(String message) {
    _show(message, AppColors.greenColor);
  }

  static void showWarning(String message) {
    _show(message, AppColors.defaultColor);
  }

  static void _show(String message, Color color) {
    scaffoldKey.currentState?.hideCurrentSnackBar();
    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        content: TextInAppWidget(
          text: message,
          textSize: 14,
          textColor: AppColors.whiteColor,
          fontWeightIndex: FontSelectionData.semiBoldFontFamily,
        ),
        backgroundColor: color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showNotification({
    required String title,
    required String description,
  }) {
    scaffoldKey.currentState?.hideCurrentSnackBar();

    scaffoldKey.currentState?.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: AppColors.greenColor,
        duration: const Duration(seconds: 4),
        margin: const EdgeInsets.all(16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextInAppWidget(
              text: title,
              textSize: 16,
              textColor: AppColors.whiteColor,
              fontWeightIndex: FontSelectionData.boldFontFamily,
            ),
            const SizedBox(height: 4),
            TextInAppWidget(
              text: description,
              textSize: 14,
              textColor: AppColors.whiteColor,
              fontWeightIndex: FontSelectionData.regularFontFamily,
            ),
          ],
        ),
      ),
    );
  }
}
