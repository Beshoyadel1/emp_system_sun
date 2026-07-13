import '../../../../../../features/notifications/data/datasource/parsers/root_parser/root_parser.dart';
import '../../../../../../features/notifications/data/model/new_order_notifications_model/new_order_notifications_model.dart';

class NewOrderParser {
  NewOrderParser({
    RootParser? rootParser,
  }) : _rootParser = rootParser ?? const RootParser();

  final RootParser _rootParser;

  NewOrderNotificationsModel? parse(
      List<Object?>? arguments,
      ) {
    final root = _rootParser.parse(arguments);

    if (root == null) {
      return null;
    }

    return NewOrderNotificationsModel.fromJson(root);
  }
}