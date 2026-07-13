import 'dart:convert';
import 'package:flutter/foundation.dart';
import '../../../../../../features/notifications/data/model/update_order_status_model_notification/update_order_status_model_notification.dart';

class UpdateOrderStatusParser {
  UpdateOrderStatusModelNotification? parse(List<Object?>? arguments) {
    try {
      if (arguments == null || arguments.isEmpty) {
        return null;
      }

      final root = arguments.first;

      if (root is! Map<String, dynamic>) {
        return null;
      }

      // لأن orderInfo عبارة عن String يحتوي على JSON
      final data = root["data"]?["data"];

      if (data is Map<String, dynamic>) {
        final orderInfo = data["orderInfo"];

        if (orderInfo is String && orderInfo.isNotEmpty) {
          data["orderInfo"] =
          jsonDecode(orderInfo) as Map<String, dynamic>;
        }
      }

      return UpdateOrderStatusModelNotification.fromJson(root);
    } catch (e, s) {
      debugPrint("UpdateOrderStatusParser Error => $e");
      debugPrintStack(stackTrace: s);
      return null;
    }
  }
}