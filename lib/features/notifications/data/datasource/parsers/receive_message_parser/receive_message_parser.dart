import '../../../../../../features/notifications/data/model/receive_message_notification_model/receive_message_notification_model.dart';
import '../../../../../../features/notifications/data/datasource/parsers/root_parser/root_parser.dart';

class ReceiveMessageParser {
  ReceiveMessageParser({
    RootParser? rootParser,
  }) : _rootParser = rootParser ?? const RootParser();

  final RootParser _rootParser;

  ReceiveMessageNotificationModel? parse(
      List<Object?>? arguments,
      ) {
    final root = _rootParser.parse(arguments);

    if (root == null) {
      return null;
    }

    return ReceiveMessageNotificationModel.fromJson(root);
  }
}