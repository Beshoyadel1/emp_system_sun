import '../../../../../../features/notifications/data/datasource/signalr_datasource/signalr_connection/signalr_connection.dart';
import '../../../../../../features/notifications/data/datasource/signalr_datasource/signalr_event_register/signalr_event_register.dart';
import '../../../../../../features/notifications/presentation/module/notification_module/notification_module.dart';

class SignalRService {
  SignalRService._();

  static final SignalRService instance = SignalRService._();

  late final SignalREventRegister _events = SignalREventRegister(
    onReceiveNotification: _handleReceiveNotification,
    onReceiveMessage: _handleReceiveMessage,
    onNewOrder: _handleNewOrder,
    onUpdateOrderStatus: _handleUpdateOrderStatus,
    onNewServiceRequest: _handleNewServiceRequest,
    onNewServiceOffer: _handleNewServiceOffer,
    onTransferCarOwnership: _handleTransferCarOwnership,
    onOpenCloseChat: _handleOpenCloseChat,
  );

  bool get isConnected => SignalRConnection.instance.isConnected;

  Future<void> connect({
    required String hubUrl,
  }) async {
    await SignalRConnection.instance.connect(
      hubUrl: hubUrl,
      onReconnect: () {},
      onClose: (error) async {},
    );

    _events.register(
      SignalRConnection.instance.hub!,
    );
  }

  Future<void> disconnect() async {
    await SignalRConnection.instance.disconnect();
  }

  Future<void> _handleReceiveNotification(
      List<Object?>? args) {
    return NotificationModule.instance
        .receiveNotificationHandler
        .handle(args);
  }

  Future<void> _handleReceiveMessage(
      List<Object?>? args,
      ) {
    return NotificationModule.instance
        .receiveMessageHandler
        .handle(args);
  }

  Future<void> _handleNewOrder(List<Object?>? args) {
    return NotificationModule.instance
        .newOrderHandler
        .handle(args);
  }


  Future<void> _handleUpdateOrderStatus(List<Object?>? args) {
    return NotificationModule.instance
        .updateOrderStatusHandler
        .handle(args);
  }

  void _handleNewServiceRequest(List<Object?>? args) {}

  void _handleNewServiceOffer(List<Object?>? args) {}

  void _handleTransferCarOwnership(List<Object?>? args) {}

  void _handleOpenCloseChat(List<Object?>? args) {}
}