import 'package:emp_system_sun/core/theming/text_styles.dart';
import 'package:emp_system_sun/core/language/language_constant.dart';
import 'package:flutter/material.dart';

Future<bool?> showBackDialog({required BuildContext context}) {
  return showDialog<bool>(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        title: const SizedBox(
          width: 300,
          child: Center(
            child: TextInAppWidget(
              text: AppLanguageKeys.confirmExit,
              textSize: 14,
              textAlign: TextAlign.center,
            ),
          ),
        ),
        content: const SizedBox(
          height: 50,
          width: 300,
          child: Center(
            child: TextInAppWidget(
              text: AppLanguageKeys.confirmLeave,
              textSize: 14,
              textAlign: TextAlign.center,
              textColor: Colors.black,
            ),
          ),
        ),
        actions: <Widget>[
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(true),
                  child:
                      TextInAppWidget(text: AppLanguageKeys.ok, textSize: 14),
                ),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: TextInAppWidget(
                      text: AppLanguageKeys.cancel, textSize: 14),
                ),
              ]),
        ],
      );
    },
  );
}
