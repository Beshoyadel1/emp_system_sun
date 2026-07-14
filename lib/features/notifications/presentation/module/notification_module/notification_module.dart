import '../../../../../../features/notifications/data/datasource/parsers/receive_message_parser/receive_message_parser.dart';
import '../../../../../../features/notifications/presentation/handlers/receive_message_handler/receive_message_handler.dart';
import '../../../../../../features/notifications/data/datasource/parsers/update_order_status_parser/update_order_status_parser.dart';
import '../../../../../../features/notifications/presentation/handlers/update_order_status_handler/update_order_status_handler.dart';
import '../../../../../../features/notifications/data/datasource/parsers/new_order_parser/new_order_parser.dart';
import '../../../../../../features/notifications/data/datasource/parsers/receive_notification_parser/receive_notification_parser.dart';
import '../../../../../../features/notifications/data/repository/notification_repository/notification_repository_impl.dart';
import '../../../../../../features/notifications/presentation/handlers/new_order_handler/new_order_handler.dart';
import '../../../../../../features/notifications/presentation/handlers/receive_notification_handler/receive_notification_handler.dart';
import '../../../../../../features/notifications/presentation/services/dialog_service/dialog_service.dart';
import '../../../../../../features/notifications/presentation/services/navigation_service/navigation_service.dart';

class NotificationModule {
  NotificationModule._();
  late final navigationService = const NotificationNavigationService();


  static final NotificationModule instance = NotificationModule._();

  /// Repository
  late final NotificationRepositoryImpl repository =
  NotificationRepositoryImpl();

  /// Shared Services
  late final NotificationDialogService dialogService =
  NotificationDialogService();

  /// Parsers
  late final ReceiveNotificationParser receiveNotificationParser =
  ReceiveNotificationParser();


  late final ReceiveNotificationHandler receiveNotificationHandler =
  ReceiveNotificationHandler(
      parser: receiveNotificationParser,
      repository: repository,
      dialogService: dialogService,
      navigationService: navigationService
  );

  late final newOrderParser = NewOrderParser();

  late final newOrderHandler = NewOrderHandler(
      parser: newOrderParser,
      dialogService: dialogService,
      navigationService:navigationService
  );

  late final updateOrderStatusParser =
  UpdateOrderStatusParser();

  late final updateOrderStatusHandler =
  UpdateOrderStatusHandler(
    parser: updateOrderStatusParser,
    dialogService: dialogService,
    navigationService: navigationService,
  );

  late final receiveMessageParser =
  ReceiveMessageParser();

  late final receiveMessageHandler =
  ReceiveMessageHandler(
    parser: receiveMessageParser,
    dialogService: dialogService,
    navigationService: navigationService,
  );
}