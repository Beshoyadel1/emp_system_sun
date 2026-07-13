import 'dart:convert';
import '../../../../../../features/notifications/data/datasource/parsers/root_parser/root_parser.dart';
import '../../../../../../features/notifications/data/model/receive_notification_model/receive_notification_model.dart';

class ReceiveNotificationParser {
  ReceiveNotificationParser({
    RootParser? rootParser,
  }) : _rootParser = rootParser ?? const RootParser();

  final RootParser _rootParser;

  ReceiveNotificationModel? parse(List<Object?>? arguments) {
    final root = _rootParser.parse(arguments);

    if (root == null) {
      return null;
    }

    final notification =
    Map<String, dynamic>.from(root["data"] as Map<dynamic, dynamic>);

    final data =
    Map<String, dynamic>.from(notification["data"] as Map<dynamic, dynamic>);

    final notificationJson = jsonDecode(
      data["notification"] as String,
    ) as Map<String, dynamic>;

    return ReceiveNotificationModel.fromJson(notificationJson);
  }

  int? getUserId(List<Object?>? arguments) {
    final root = _rootParser.parse(arguments);

    return root?["userId"];
  }

  int? getUserType(List<Object?>? arguments) {
    final root = _rootParser.parse(arguments);

    return root?["userType"];
  }
}