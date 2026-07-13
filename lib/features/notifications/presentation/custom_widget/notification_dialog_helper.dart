import 'package:flutter/material.dart';
import '../../../../../../features/notifications/presentation/pages/notification_dialog/notification_dialog.dart';

class NotificationDialogHelper {
  static Future<void> show({
    required BuildContext context,
    required String title,
    required String subTitle,
    required Future<void> Function() onClose,
    required Future<void> Function() onView,
    bool barrierDismissible = false,
  }) {
    return showDialog(
      context: context,
      barrierDismissible: barrierDismissible,
      builder: (_) {
        return NotificationDialog(
          title: title,
          subTitle: subTitle,
          onClose: onClose,
          onView: onView,
        );
      },
    );
  }
}