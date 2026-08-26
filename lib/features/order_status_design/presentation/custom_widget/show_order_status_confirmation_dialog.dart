import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../../../../../../../../core/language/language_constant.dart';
import '../../../../../../../../../core/theming/colors.dart';
import '../../../../../../../../../core/theming/text_styles.dart';

Future<bool?> showOrderStatusConfirmationDialog(
    BuildContext context, {
      required String actionText,
      required Color actionColor,
    }) {
  return showDialog<bool>(
    context: context,
    builder: (dialogContext) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        title: TextInAppWidget(
          text: AppLanguageKeys.confirmAction,
          textSize: 20,
          textColor: actionColor,
          isTextCenter: true,
        ),
        content: const TextInAppWidget(
          text: AppLanguageKeys.areYouSure,
          textSize: 15,
          textColor: AppColors.darkColor,
          isTextCenter: true,
        ),
        actions: [
          // =====================================================
          // CANCEL
          // =====================================================

          TextButton(
            onPressed: () {
              Navigator.pop(
                dialogContext,
                false,
              );
            },
            child: const TextInAppWidget(
              text: AppLanguageKeys.cancel,
              textSize: 14,
              textColor: AppColors.greyColor,
            ),
          ),

          // =====================================================
          // CONFIRM
          // =====================================================

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: actionColor,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            onPressed: () {
              Navigator.pop(
                dialogContext,
                true,
              );
            },
            child: TextInAppWidget(
              text: actionText,
              textSize: 14,
              textColor: AppColors.whiteColor,
            ),
          ),
        ],
      );
    },
  );
}